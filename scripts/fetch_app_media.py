#!/usr/bin/env python3
"""Fetch app icons / screenshots / descriptions from Apple's iTunes Lookup API
and wire them into assets/data/apps.json.

iOS only (Apple has a public JSON API; Google Play does not). Android-only apps
keep iconAsset=null (letter-tile placeholder). Re-runnable: overwrites media and
re-augments apps.json. Run from repo root:  python3 scripts/fetch_app_media.py
"""
import json
import os
import ssl
import time
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
APPS = os.path.join(ROOT, "assets/data/apps.json")
MEDIA_DIR = os.path.join(ROOT, "assets/images/projects")
COUNTRIES = ["us", "kw", "sa", "ae", "eg", "qa"]
MAX_SHOTS = 6
CTX = ssl._create_unverified_context()
UA = {"User-Agent": "Mozilla/5.0 (portfolio media fetch)"}


def get(url):
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=20, context=CTX) as r:
        return r.read()


def _shot_count(r):
    return len(r.get("screenshotUrls") or r.get("ipadScreenshotUrls") or [])


def lookup(app_store_id):
    """Try all storefronts; return the result with the most screenshots
    (region-locked Gulf apps often list in `us` but with no screenshots)."""
    best, best_shots = None, -1
    for ctry in COUNTRIES:
        url = f"https://itunes.apple.com/lookup?id={app_store_id}&country={ctry}"
        try:
            data = json.loads(get(url).decode("utf-8"))
        except Exception:
            continue
        if data.get("resultCount", 0) >= 1:
            r = data["results"][0]
            n = _shot_count(r)
            if n > best_shots:
                best, best_shots = r, n
            if n >= MAX_SHOTS:
                break  # already enough
        time.sleep(0.1)
    return best


def cdn_width(url, w=600):
    """Rewrite an mzstatic image URL's trailing size token to request a fixed
    width straight from Apple's CDN (sharp, server-side scaled — no upscaling)."""
    parts = url.split("/")
    parts[-1] = f"{w}x0w.jpg"
    return "/".join(parts)


def download(url, dest):
    try:
        body = get(url)
    except Exception as e:
        print(f"      ! download failed: {e}")
        return False
    with open(dest, "wb") as f:
        f.write(body)
    return True


def main():
    os.makedirs(MEDIA_DIR, exist_ok=True)
    apps = json.load(open(APPS))
    for app in apps:
        sid = (app.get("storeLinks") or {}).get("appStore")
        name = app["name"]
        appid = app["id"]
        if not sid:
            print(f"- {name}: android-only / no App Store id -> placeholder")
            continue
        res = lookup(sid)
        if not res:
            print(f"- {name}: NOT FOUND in any storefront")
            continue
        # Icon (256px). Skip re-download if the file is already present.
        icon_dest = os.path.join(MEDIA_DIR, f"{appid}_icon.png")
        icon_url = res.get("artworkUrl512") or res.get("artworkUrl100")
        if os.path.exists(icon_dest):
            app["iconAsset"] = f"assets/images/projects/{appid}_icon.png"
        elif icon_url and download(cdn_width(icon_url, 256), icon_dest):
            app["iconAsset"] = f"assets/images/projects/{appid}_icon.png"
        # Screenshots (phone, fall back to iPad) — 600px wide from the CDN.
        shots = res.get("screenshotUrls") or res.get("ipadScreenshotUrls") or []
        saved = []
        for i, s in enumerate(shots[:MAX_SHOTS], start=1):
            dest = os.path.join(MEDIA_DIR, f"{appid}_{i}.jpg")
            if download(cdn_width(s, 600), dest):
                saved.append(f"assets/images/projects/{appid}_{i}.jpg")
        if saved:
            app["screenshots"] = saved
        # Description
        desc = (res.get("description") or "").strip()
        if desc:
            app["description"] = desc
        print(f"- {name}: icon={'iconAsset' in app} shots={len(saved)} descLen={len(desc)}")
        time.sleep(0.25)  # be polite to the API

    json.dump(apps, open(APPS, "w"), ensure_ascii=False, indent=2)
    print("\nWrote", APPS)


if __name__ == "__main__":
    main()
