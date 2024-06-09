// line_animation.dart
import 'package:flutter/material.dart';

class LineAnimation extends StatefulWidget {

  final double screenWidth;

  const LineAnimation({super.key, required this.screenWidth});

  @override
  State<LineAnimation> createState() => _LineAnimationState();
}

class _LineAnimationState extends State<LineAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Hız değişkenine göre süreyi hesaplayın
    _controller = AnimationController(
      duration: Duration(seconds: (3 / 2).round()),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: widget.screenWidth - 50)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: LinePainter(_animation.value),
            );
          },
        ),
      ],
    );
  }
}

class LinePainter extends CustomPainter {
  final double xOffset;

  LinePainter(this.xOffset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1;

    canvas.drawLine(Offset(xOffset, size.height / 2), Offset(xOffset + 50, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
