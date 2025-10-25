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
  double progress = 0.0;

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
    _animateProgress();
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  void _animateProgress() async {
    // Example: animate progress up and down smoothly
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        progress += 0.02;
        if (progress > 1) progress = 0;
      });
    }
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
             // SizedBox(height: screenHeight * 0.02),
              Image.asset(
                "assets/simley_toothy_loading_screen.png",
                width: screenWidth * 0.65,
              ),
              SizedBox(height: screenHeight * 0.05),
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
                      child: RepaintBoundary(
                        child: AnimatedContainer(
                          curve: Curves.bounceInOut,
                          duration: const Duration(milliseconds: 2000),
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            color: kMainLoadingWhitContainerColor,
                            borderRadius: BorderRadius.circular(300),
                            boxShadow: [
                              BoxShadow(
                                color: kMainLoadingWhitContainerColor
                                    .withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 1,
                                spreadRadius: 30,
                              ),
                            ],
                          ),
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
                    bottom: 18,
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
              SizedBox(height: screenHeight * 0.06),
              ClipRRect(
                child: Image.asset(
                  "assets/loading_screen_loading.png",
                  width: 160,
                  height: 160,
                ),
              ),
              //SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      // bottom shadow — gives depth
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 6
                        ,
                      ),
                      // subtle top highlight — makes it look raised
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        kMainLoadingWhitContainerColor.withOpacity(0.9),
                        kMainLoadingWhitContainerColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      builder:
                          (context, value, _) => LinearProgressIndicator(
                            value: value,
                            minHeight: 20,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              kMainLoadingIndicatorYellowdark,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
