import 'dart:math';

import 'package:flutter/material.dart';

class AppShake extends StatefulWidget {
  final Widget child;
  const AppShake({super.key, required this.child});

  @override
  State<AppShake> createState() => _AppShakeState();
}

class _AppShakeState extends State<AppShake> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double shake(double animation) =>
      2 * (0.5 - (0.5 - Curves.bounceInOut.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        return Transform.rotate(
          angle: shake(_animationController.value) * pi / 8,
          child: child,
        );
      },
    );
  }
}
