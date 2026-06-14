import 'package:clever_portfolio/features/projects/data/models/app_project_model.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppProjectModel.fromJson -> toEntity', () {
    test('both platforms: builds urls, infers platforms, keeps media', () {
      final entity = AppProjectModel.fromJson(const {
        'index': 1,
        'id': 'edu-market',
        'name': 'Edu Market',
        'category': 'education',
        'tagline': 'Education marketplace',
        'featured': true,
        'storeLinks': {'googlePlay': 'com.x.edu', 'appStore': '6749850424'},
        'iconAsset': 'assets/images/projects/edu-market_icon.png',
        'screenshots': ['a.jpg', 'b.jpg'],
      }).toEntity();

      expect(entity.category, AppCategory.education);
      expect(entity.platforms, [AppPlatform.android, AppPlatform.ios]);
      expect(
        entity.androidUrl,
        'https://play.google.com/store/apps/details?id=com.x.edu',
      );
      expect(entity.iosUrl, 'https://apps.apple.com/app/id6749850424');
      expect(entity.featured, isTrue);
      expect(entity.screenshots, hasLength(2));
      expect(entity.indexLabel, '01');
    });

    test('iOS-only: only ios platform, no android url', () {
      final entity = AppProjectModel.fromJson(const {
        'index': 7,
        'id': 'montajat',
        'name': 'Montajat',
        'category': 'ecommerce',
        'tagline': 'Store',
        'storeLinks': {'appStore': '123'},
      }).toEntity();

      expect(entity.platforms, [AppPlatform.ios]);
      expect(entity.hasAndroid, isFalse);
      expect(entity.hasIos, isTrue);
    });

    test('android-only: only android platform', () {
      final entity = AppProjectModel.fromJson(const {
        'index': 31,
        'id': 'stock-delivery',
        'name': 'Stock Delivery',
        'category': 'business',
        'tagline': 'Agents',
        'storeLinks': {'googlePlay': 'com.x.sd'},
      }).toEntity();

      expect(entity.platforms, [AppPlatform.android]);
      expect(entity.hasIos, isFalse);
      expect(entity.hasScreenshots, isFalse);
    });

    test('unknown category falls back to ecommerce', () {
      final entity = AppProjectModel.fromJson(const {
        'index': 99,
        'id': 'x',
        'name': 'X',
        'category': 'nonsense',
        'tagline': 't',
      }).toEntity();
      expect(entity.category, AppCategory.ecommerce);
    });
  });
}
