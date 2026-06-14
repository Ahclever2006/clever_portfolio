import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:flutter/widgets.dart';

/// Presentation-layer mapping from [AppCategory] to its themed hue + i18n key
/// (keeps the core `CategoryColors` extension free of feature imports).
extension AppCategoryColorX on AppCategory {
  /// The themed accent hue for this category.
  Color hue(BuildContext context) {
    final c = context.categoryColors;
    return switch (this) {
      AppCategory.ecommerce => c.ecommerce,
      AppCategory.games => c.games,
      AppCategory.booking => c.booking,
      AppCategory.business => c.business,
      AppCategory.food => c.food,
      AppCategory.services => c.services,
      AppCategory.medical => c.medical,
      AppCategory.education => c.education,
      AppCategory.travel => c.travel,
    };
  }

  /// The `AppStrings` translation key for this category's label.
  String get trKey => switch (this) {
    AppCategory.ecommerce => AppStrings.catEcommerce,
    AppCategory.games => AppStrings.catGames,
    AppCategory.booking => AppStrings.catBooking,
    AppCategory.business => AppStrings.catBusiness,
    AppCategory.food => AppStrings.catFood,
    AppCategory.services => AppStrings.catServices,
    AppCategory.medical => AppStrings.catMedical,
    AppCategory.education => AppStrings.catEducation,
    AppCategory.travel => AppStrings.catTravel,
  };
}
