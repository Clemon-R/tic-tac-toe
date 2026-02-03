import 'package:flutter/material.dart';

class AppLoading extends StatefulWidget {
  final double sizeWave;
  final Widget child;
  final bool isAnimated;
  const AppLoading({
    super.key,
    this.sizeWave = 0.5,
    required this.child,
    this.isAnimated = true,
  });

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  double startAngle = 0;
  double endAngle = 0;

  @override
  void initState() {
    super.initState();
    startAngle = (1 - widget.sizeWave) / 2;
    endAngle = startAngle + widget.sizeWave;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        if (!widget.isAnimated) {
          return child!;
        }
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: getColors(_animationController.value),
              stops: getStops(_animationController.value),
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }

  List<double> getStops(double progress) {
    final nextStart = (startAngle + progress) % 1;
    final nextEnd = (nextStart + widget.sizeWave) % 1;
    if (nextEnd < nextStart) {
      return [0, nextEnd, nextStart];
    }
    return [0, nextStart, nextEnd];
  }

  List<Color> getColors(double progress) {
    final nextStart = (startAngle + progress) % 1;
    final nextEnd = (nextStart + widget.sizeWave) % 1;
    if (nextEnd < nextStart) {
      return [Colors.white, Colors.black, Colors.white];
    }
    return [Colors.black, Colors.white, Colors.black];
  }
}
