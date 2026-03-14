import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class GlowingRegion extends StatefulWidget {
  final Widget child;
  final bool glowing;

  const GlowingRegion({super.key, required this.child, this.glowing = true});

  @override
  State<GlowingRegion> createState() => _GlowingRegionState();
}

class _GlowingRegionState extends State<GlowingRegion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    // 0.5 seconds, just like your CSS animation!
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // This makes the glow transition smoothly between 50% and 100% intensity
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Makes it pulse back and forth infinitely
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // We apply the animated opacity to whatever widget is inside
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}

// 2. Extracts ONLY the target shape so we can blur it and border it
String extractIsolatedShape(
    String rawSvg, String targetId, String color, String strokeWidth) {
  final document = XmlDocument.parse(rawSvg);
  final svgRoot = document.findAllElements('svg').first;
  final viewBox = svgRoot.getAttribute('viewBox') ?? "0 0 100 100";

  try {
    final targetElement = document.findAllElements('*').firstWhere(
          (element) => element.getAttribute('id') == targetId,
        );

    // Make it hollow, apply the requested stroke, and strip old filters
    targetElement.setAttribute('fill', 'none');
    targetElement.setAttribute('stroke', color);
    targetElement.setAttribute('stroke-width', strokeWidth);
    targetElement.removeAttribute('filter');

    // Return a mini-SVG containing ONLY this shape
    return '''
      <svg viewBox="$viewBox">
        ${targetElement.toXmlString()}
      </svg>
    ''';
  } catch (e) {
    return '<svg viewBox="$viewBox"></svg>'; // Empty fallback
  }
}
