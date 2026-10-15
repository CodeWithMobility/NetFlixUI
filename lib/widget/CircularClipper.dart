// @dart=2.17

import 'package:flutter/material.dart';

class CircularClipper extends CustomClipper<Path> {
  const CircularClipper();

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 50)
      ..quadraticBezierTo(
          size.width / 4, size.height, size.width / 2, size.height)
      ..quadraticBezierTo(
        size.width - size.width / 4,
        size.height,
        size.width,
        size.height - 50,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) => false;
}

class ClipShadowPath extends StatelessWidget {
  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowPainter(clipper: clipper, shadow: shadow),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowPainter extends CustomPainter {
  const _ClipShadowPainter({required this.shadow, required this.clipper});

  final Shadow shadow;
  final CustomClipper<Path> clipper;

  @override
  void paint(Canvas canvas, Size size) {
    final path = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(path, shadow.toPaint());
  }

  @override
  bool shouldRepaint(_ClipShadowPainter oldDelegate) =>
      oldDelegate.shadow != shadow || oldDelegate.clipper != clipper;
}
