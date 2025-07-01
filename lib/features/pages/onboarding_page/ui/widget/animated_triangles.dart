import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedTriangles extends StatefulWidget {
  const AnimatedTriangles({super.key});

  @override
  State<AnimatedTriangles> createState() => _AnimatedTrianglesState();
}

class _AnimatedTrianglesState extends State<AnimatedTriangles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Triangle> _triangles = [];

  final Paint _trianglePaint = Paint()..style = PaintingStyle.fill;
  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    for (var i = 0; i < 15; i++) {
      _triangles.add(Triangle());
    }
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (final context, final child) => CustomPaint(
      painter: TrianglePainter(
        triangles: _triangles,
        animationValue: _controller.value,
        screenSize: MediaQuery.of(context).size,
        trianglePaint: _trianglePaint,
        borderPaint: _borderPaint,
      ),
      size: Size.infinite,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Triangle {
  Triangle()
    : relativeX = Random().nextDouble(),
      relativeY = Random().nextDouble(),
      size = Random().nextDouble() * 60 + 30,
      speedFactor = Random().nextDouble() * 0.5 + 0.5,
      color = Colors.red;
  final double relativeX;
  final double relativeY;
  final double size;
  final double speedFactor;
  final Color color;
}

class TrianglePainter extends CustomPainter {
  TrianglePainter({
    required this.triangles,
    required this.animationValue,
    required this.screenSize,
    required this.trianglePaint,
    required this.borderPaint,
  });
  final List<Triangle> triangles;
  final double animationValue;
  final Size screenSize;

  final Paint trianglePaint;
  final Paint borderPaint;

  @override
  void paint(final Canvas canvas, final Size size) {
    for (var triangle in triangles) {
      final baseX = triangle.relativeX * screenSize.width;
      final baseY = triangle.relativeY * screenSize.height;
      final bounceOffset =
          sin(animationValue * 2 * pi * triangle.speedFactor) * 20;
      final adjustedX = baseX;
      final adjustedY = baseY + bounceOffset;

      final opacity = (sin(animationValue * 2 * pi) + 1) / 2;
      trianglePaint.color = triangle.color.withAlpha((opacity * 0x80).toInt());
      borderPaint.color = triangle.color;

      final height = triangle.size * sqrt(3) / 2;
      final path = Path()
        ..moveTo(adjustedX, adjustedY + height * 2 / 3)
        ..lineTo(adjustedX + triangle.size / 2, adjustedY - height / 3)
        ..lineTo(adjustedX - triangle.size / 2, adjustedY - height / 3)
        ..close();

      canvas
        ..drawPath(path, trianglePaint)
        ..drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant final TrianglePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
