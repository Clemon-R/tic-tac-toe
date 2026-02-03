import 'package:flutter/material.dart';

class AppFade extends StatefulWidget {
  final Widget originalWidget;
  final Widget newWidget;
  const AppFade({
    super.key,
    required this.originalWidget,
    required this.newWidget,
  });

  @override
  State<AppFade> createState() => _AppFadeState();
}

class _AppFadeState extends State<AppFade> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          child: widget.originalWidget,
          builder: (context, child) {
            return Opacity(opacity: 1 - _animation.value, child: child);
          },
        ),
        AnimatedBuilder(
          animation: _animation,
          child: widget.newWidget,
          builder: (context, child) {
            return Opacity(opacity: _animation.value, child: child);
          },
        ),
      ],
    );
  }
}
