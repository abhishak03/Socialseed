import 'package:flutter/material.dart';
import 'dart:math' as math;

class OpacityAnimationBetweenLeaves extends StatefulWidget {
  const OpacityAnimationBetweenLeaves({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OpacityAnimationBetweenLeavesState createState() =>
      _OpacityAnimationBetweenLeavesState();
}

class _OpacityAnimationBetweenLeavesState
    extends State<OpacityAnimationBetweenLeaves>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0,
            curve: Curves
                .easeInOut), // Delay the appearance of the second leaf by 0.5 seconds
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomPaint(
            size: const Size(300, 200),
            painter: LeafPainter(
              opacityAnimation: _opacityAnimation,
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "socialseed",
            style: TextStyle(
                fontSize: 48, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class LeafPainter extends CustomPainter {
  final Animation<double> opacityAnimation;

  LeafPainter({required this.opacityAnimation})
      : super(repaint: opacityAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2,
        size.height / 2 - 120); // Move to the center of the canvas
    canvas.rotate(math.pi / 4); // Rotate the canvas by 45 degrees
    // Define path for the first leaf
    final Path path1 = Path();
    path1.moveTo(size.width / 2, size.height);
    path1.quadraticBezierTo(
        size.width * 0.68, size.height * 0.5, size.width / 2, 0);
    path1.quadraticBezierTo(
        size.width * 0.32, size.height * 0.5, size.width / 2, size.height);

    // Draw the first leaf with full opacity
    Paint paint1 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawPath(path1, paint1);

    // Define path for the second leaf
    final Path path2 = Path();
    path2.moveTo(size.width - 150, size.height + 20);
    path2.quadraticBezierTo(
        size.width * 0.28, size.height * 0.5, size.width - 150, 0);
    path2.quadraticBezierTo(size.width * 0.15, size.height * 0.5,
        size.width - 150, size.height + 20);
    // Draw the second leaf with opacity animation
    Paint paint2 = Paint()
      ..color = Colors.red.withOpacity(opacityAnimation.value)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
