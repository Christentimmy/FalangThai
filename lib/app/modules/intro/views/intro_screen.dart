import 'dart:math' as math;
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8B5FF),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: ShapesPainter(),
            size: Size(300, 300),
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for dotted lines
    final dottedPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw curved dotted lines connecting points
    _drawDottedCurve(canvas, size, dottedPaint);

    // Draw gradient star
    _drawGradientStar(canvas, size);
  }

  void _drawDottedCurve(Canvas canvas, Size size, Paint paint) {
    // Define connection points (similar to profile picture positions)
    final point1 = Offset(size.width * 0.3, size.height * 0.2);
    final point2 = Offset(size.width * 0.7, size.height * 0.3);
    final point3 = Offset(size.width * 0.2, size.height * 0.6);

    // Create curved paths between points
    final path1 = Path();
    path1.moveTo(point1.dx, point1.dy);
    path1.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1, // Control point
      point2.dx,
      point2.dy,
    );

    final path2 = Path();
    path2.moveTo(point2.dx, point2.dy);
    path2.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.5, // Control point
      point3.dx,
      point3.dy,
    );

    final path3 = Path();
    path3.moveTo(point3.dx, point3.dy);
    path3.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.3, // Control point
      point1.dx,
      point1.dy,
    );

    // Draw dotted curves
    _drawDottedPath(canvas, path1, paint);
    _drawDottedPath(canvas, path2, paint);
    _drawDottedPath(canvas, path3, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      const dashLength = 8.0;
      const gapLength = 6.0;
      double distance = 0.0;
      bool draw = true;

      while (distance < pathMetric.length) {
        final nextDistance = distance + (draw ? dashLength : gapLength);
        if (draw) {
          final extractPath = pathMetric.extractPath(
            distance,
            math.min(nextDistance, pathMetric.length),
          );
          canvas.drawPath(extractPath, paint);
        }
        distance = nextDistance;
        draw = !draw;
      }
    }
  }

  void _drawGradientStar(Canvas canvas, Size size) {
    // Star position
    final starCenter = Offset(size.width * 0.8, size.height * 0.8);
    final starRadius = 25.0;

    // Create star path
    final starPath = _createStarPath(starCenter, starRadius);

    // Create gradient paint
    final gradientPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0xFFFFE4B5), // Light peach
          Color(0xFFFF69B4), // Hot pink
          Color(0xFF9370DB), // Medium slate blue
          Color(0xFF4B0082), // Indigo
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: starCenter, radius: starRadius))
      ..style = PaintingStyle.fill;

    // Draw the star
    canvas.drawPath(starPath, gradientPaint);

    // Add a subtle glow effect
    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [Colors.white.withOpacity(0.6), Colors.transparent],
            stops: [0.0, 1.0],
          ).createShader(
            Rect.fromCircle(center: starCenter, radius: starRadius * 1.5),
          )
      ..style = PaintingStyle.fill;

    canvas.drawCircle(starCenter, starRadius * 1.2, glowPaint);
    canvas.drawPath(starPath, gradientPaint);
  }

  Path _createStarPath(Offset center, double radius) {
    const numPoints = 5;
    const angle = math.pi / numPoints;
    final path = Path();

    for (int i = 0; i < numPoints * 2; i++) {
      final currentAngle = i * angle - math.pi / 2;
      final currentRadius = i.isEven ? radius : radius * 0.4;
      final x = center.dx + currentRadius * math.cos(currentAngle);
      final y = center.dy + currentRadius * math.sin(currentAngle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
