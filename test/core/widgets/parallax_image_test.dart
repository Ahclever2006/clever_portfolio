import 'package:clever_portfolio/core/theme/app_theme.dart';
import 'package:clever_portfolio/core/widgets/page_scroll.dart';
import 'package:clever_portfolio/core/widgets/parallax_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

// A non-Image fallback so a failed asset decode neither throws nor adds a
// second Image to the tree (keeping image finders unambiguous).
Widget _noImageError(BuildContext context, Object error, StackTrace? stack) =>
    const SizedBox.shrink();

// Vertical translation applied to the (only) parallax transform in [scope]
// (defaults to the single ParallaxImage in the tree). This is the visible crop
// offset — 0 means the image sits centred / static.
double _translateY(WidgetTester tester, {Finder? scope}) {
  final finder = find.descendant(
    of: scope ?? find.byType(ParallaxImage),
    matching: find.byType(Transform),
  );
  return tester.widget<Transform>(finder.first).transform.getTranslation().y;
}

Widget _app(Widget body) => ScreenUtilInit(
  designSize: const Size(1440, 1024),
  builder: (context, _) => MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: body),
  ),
);

// A 300px-tall ParallaxImage at content-offset [top..top+300] inside an outer
// vertical scroll wired through PageScroll. [reducedMotion] flips
// disableAnimations; [pageView] nests it in a horizontal PageView (the real
// featured-card structure).
Widget _scrolled(
  ScrollController controller, {
  double top = 2000,
  bool reducedMotion = false,
  bool pageView = false,
}) {
  const image = ParallaxImage(
    asset: 'assets/x.png',
    errorBuilder: _noImageError,
  );
  return Builder(
    builder: (context) {
      final scroll = SingleChildScrollView(
        controller: controller,
        child: PageScroll(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: top),
              SizedBox(
                height: 300,
                width: 300,
                child: pageView
                    ? PageView(children: const [image, SizedBox()])
                    : image,
              ),
              const SizedBox(height: 2000),
            ],
          ),
        ),
      );
      if (!reducedMotion) return scroll;
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: true),
        child: scroll,
      );
    },
  );
}

void main() {
  testWidgets('renders a cover-fit image, centred, with no PageScroll '
      'ancestor', (tester) async {
    await tester.pumpWidget(
      _app(
        const SizedBox(
          height: 300,
          width: 300,
          child: ParallaxImage(
            asset: 'assets/x.png',
            errorBuilder: _noImageError,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.widget<Image>(find.byType(Image)).fit, BoxFit.cover);
    expect(_translateY(tester), 0);
  });

  testWidgets('crop translation tracks scroll position in direction and '
      'magnitude', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_app(_scrolled(controller)));
    await tester.pumpAndSettle();

    Future<double> yAt(double offset) async {
      controller.jumpTo(offset);
      await tester.pump();
      return _translateY(tester);
    }

    // As scroll offset grows the card rises through the viewport, so the crop
    // slides — translation moves monotonically in one direction.
    final low = await yAt(0); // card far below the viewport
    final mid = await yAt(1850); // card centred in the viewport
    final high = await yAt(2150); // card at the viewport top
    expect(low, lessThan(mid));
    expect(mid, lessThan(high));

    // Travel is tens of pixels (frame 300 * _overflow 0.18 * 2 ≈ 108), not an
    // epsilon — this fails if the effect is shrunk toward zero or its sign is
    // flipped. The midpoint (card centred) sits at the static, centred pose.
    expect(high - low, greaterThan(40));
    expect(mid, closeTo(0, 0.5));
  });

  testWidgets('an animated scroll (animateTo) drives the crop', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_app(_scrolled(controller)));
    await tester.pumpAndSettle();

    final before = _translateY(tester);
    // animateTo only advances as frames are pumped, so kick it off and let
    // pumpAndSettle drive it to completion — awaiting the future first would
    // deadlock (no frames pump while suspended), timing the test out.
    final animation = controller.animateTo(
      2150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    await tester.pumpAndSettle();
    await animation;

    expect(_translateY(tester), greaterThan(before));
  });

  testWidgets('parallax is driven by the OUTER vertical scroll even when the '
      'image sits inside a horizontal PageView', (tester) async {
    // PageScroll exists so the crop follows the page scroll, not the card's own
    // horizontal PageView. A regression to Scrollable.of(context) would read
    // the (unscrolled) PageView here and this test would catch it.
    final outer = ScrollController();
    addTearDown(outer.dispose);
    await tester.pumpWidget(_app(_scrolled(outer, pageView: true)));
    await tester.pumpAndSettle();

    final before = _translateY(tester);
    outer.jumpTo(2000);
    await tester.pump();

    expect(_translateY(tester), isNot(closeTo(before, 1)));
  });

  testWidgets('each instance measures its own position independently', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      _app(
        SingleChildScrollView(
          controller: controller,
          child: PageScroll(
            controller: controller,
            child: Column(
              children: const [
                SizedBox(height: 60),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ParallaxImage(
                    asset: 'assets/a.png',
                    errorBuilder: _noImageError,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ParallaxImage(
                    asset: 'assets/b.png',
                    errorBuilder: _noImageError,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final transforms = tester
        .widgetList<Transform>(
          find.descendant(
            of: find.byType(ParallaxImage),
            matching: find.byType(Transform),
          ),
        )
        .toList();
    expect(transforms.length, 2);
    final y0 = transforms[0].transform.getTranslation().y;
    final y1 = transforms[1].transform.getTranslation().y;
    // Two cards at different viewport positions resolve to different crops.
    expect(y0, isNot(closeTo(y1, 1)));
  });

  testWidgets('crop stays fixed under reduced motion', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_app(_scrolled(controller, reducedMotion: true)));
    await tester.pumpAndSettle();

    expect(_translateY(tester), 0);

    controller.jumpTo(2000);
    await tester.pump();

    expect(_translateY(tester), 0);
  });

  testWidgets('renders the error fallback when the asset fails to decode', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        SizedBox(
          height: 300,
          width: 300,
          child: ParallaxImage(
            asset: 'assets/does-not-exist.png',
            errorBuilder: (context, error, stack) =>
                const Text('fallback', textDirection: TextDirection.ltr),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('fallback'), findsOneWidget);
  });
}
