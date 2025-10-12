import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              height: screenHeight * 1.0,
              width: screenWidth * 1.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    kMainBackgroundBlueNormal.withOpacity(1.0),
                    kMainBackgroundBlueDark,
                    kMainBackgroundBlueDark,
                  ],
                  center: Alignment.center,
                  radius: 0.90,
                ),
              ),
              duration: Duration(seconds: 5),
              curve: Curves.bounceIn,
              child: Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/splash_screen_image.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
