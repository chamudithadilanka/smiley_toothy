import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import 'package:smiley_toothy/screens/loading_screen/dart/loading%20screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // step 1 and 2 ========================== //
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  // step 3 and 4 ========================== //
  bool showSecondImage = false;
  late AnimationController _secImageSlideController;
  late Animation<Offset> _secImageSlideAnimation;

  late AnimationController _finalSlideController;
  late Animation<Offset> _finalSlideAnimation;

  Route _createSlideRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 900),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Drop-bounce effect using scale + fade
        final scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut, // bounce drop effect
          ),
        );

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: child),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 1.5, end: 2.5).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.bounceOut),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.6, 0.0), // No initial slide; stay in place
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.linear));

    _secImageSlideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _secImageSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset(0.5, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _secImageSlideController,
        curve: Curves.easeInOut,
      ),
    );

    _finalSlideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _finalSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _finalSlideController, curve: Curves.easeInOut),
    );

    // Start sequence
    _scaleController.forward().then((_) {
      setState(() => showSecondImage = true);

      _secImageSlideController.forward().then((_) {
        // ✅ Trigger final slide before navigating

        // ✅ Navigate after final slide finishes
        Navigator.pushReplacement(
          context,
          _createSlideRoute(const LoadingScreen()),
        );
      });
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent, // added background color transprant
      body: Container(
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
        child: Stack(
          children: [
            Center(
              child: SlideTransition(
                position: _finalSlideAnimation, // Moves both images left
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Image.asset(
                        'assets/splash_screen_image.png',
                        width: screenWidth * 0.3,
                      ),
                    ),
                    if (showSecondImage)
                      SlideTransition(
                        position: _secImageSlideAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            'assets/splash_screen_teeth.png',
                            width: screenWidth * 0.2,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
