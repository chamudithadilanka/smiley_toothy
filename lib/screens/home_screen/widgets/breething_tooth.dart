import 'package:flutter/cupertino.dart';

class BreathingTooth extends StatefulWidget {
  const BreathingTooth({super.key});

  @override
  State<BreathingTooth> createState() => _BreathingToothState();
}

class _BreathingToothState extends State<BreathingTooth>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200), // one breath cycle
    )..repeat(reverse: true); // ← goes forward then backward, forever

    // Scale: 0.88 → 1.0  (gentle pulse)
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Opacity: 0.65 → 1.0  (soft fade in/out)
    _opacity = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // always dispose to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: child,
          ),
        );
      },
      child: Image.asset("assets/image/lovly_tooth.png"), // built once, reused
    );
  }
}