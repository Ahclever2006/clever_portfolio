import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// A text link with a wipe-in underline on hover (web), per plan.md §3.4.
class AppTextLink extends StatefulWidget {
  /// Creates an [AppTextLink].
  const AppTextLink({required this.label, required this.onTap, super.key});

  /// Link text (already translated).
  final String label;

  /// Tap handler.
  final VoidCallback onTap;

  @override
  State<AppTextLink> createState() => _AppTextLinkState();
}

class _AppTextLinkState extends State<AppTextLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: context.motion.link,
          style: (context.text.bodyMedium ?? const TextStyle()).copyWith(
            color: context.colors.onSurface,
            decoration: _hovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: context.colors.primary,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
