import 'package:flutter/material.dart';

/// The app's text input — use instead of a raw `TextFormField`. Styling comes
/// from the theme's `inputDecorationTheme` (plan.md §3.4). Used by the contact
/// form (M4).
class AppTextField extends StatelessWidget {
  /// Creates an [AppTextField] with a floating [label].
  const AppTextField({
    required this.label,
    this.controller,
    this.hint,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    super.key,
  });

  /// Floating label text (already translated).
  final String label;

  /// Optional text controller.
  final TextEditingController? controller;

  /// Optional placeholder hint.
  final String? hint;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Optional validator.
  final String? Function(String?)? validator;

  /// Max lines (e.g. message field uses several).
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
