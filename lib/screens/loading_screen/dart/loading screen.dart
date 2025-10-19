import 'package:flutter/material.dart';
import '../../../color_theme/color_theme.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  @override
  void initState() {
    super.initState();

    // Create a controller that runs forever
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true); // Bounce back and forth

    // Define a bounce animation (using Tween and curve)
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth * 1.0,
        height: screenHeight * 1.0,
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
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                "assets/simley_toothy_loading_screen.png",
                width: screenWidth * 0.6,
              ),
              SizedBox(height: screenHeight * 0.04),
              Stack(
                children: [
                  Center(
                    child: AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bounceAnimation.value),
                          child: child,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          color: kMainLoadingWhitContainerColor,
                          borderRadius: BorderRadius.circular(300),
                          boxShadow: [
                            BoxShadow(
                              color: kMainLoadingWhitContainerColor.withOpacity(
                                0.2,
                              ),
                              offset: const Offset(0, 1),
                              blurRadius: 1,
                              spreadRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 102,
                    top: 10,
                    child: Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(300),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 97,
                    bottom: 13,
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/loading_screen_logo.png",
                        width: 220,
                        height: 220,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              ClipRRect(
                child: Image.asset(
                  "assets/loading_screen_loading.png",
                  width: 220,
                  height: 220,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
