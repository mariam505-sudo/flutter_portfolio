import 'package:flutter/material.dart';

/// شبكة خطوط خفيفة جدًا في الخلفية، بتدّي إحساس ورقة مخططات هندسية
/// من غير ما تشتت الانتباه عن المحتوى.
class BlueprintGridBackground extends StatelessWidget {
  final Widget child;
  final Color lineColor;

  const BlueprintGridBackground({
    super.key,
    required this.child,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(lineColor: lineColor),
      child: child,
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color lineColor;
  const _GridPainter({required this.lineColor});

  static const double _step = 64;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += _step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += _step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor;
}
