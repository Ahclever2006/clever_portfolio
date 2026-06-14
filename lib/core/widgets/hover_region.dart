import 'package:flutter/widgets.dart';

/// Exposes pointer-hover state to a [builder] (web/desktop). Keeps hover-driven
/// widgets stateless at the call site.
class HoverRegion extends StatefulWidget {
  /// Creates a [HoverRegion].
  const HoverRegion({required this.builder, super.key});

  /// Builds the child given the current hover state.
  final Widget Function(BuildContext context, bool hovered) builder;

  @override
  State<HoverRegion> createState() => _HoverRegionState();
}

class _HoverRegionState extends State<HoverRegion> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(context, _hovered),
    );
  }
}
