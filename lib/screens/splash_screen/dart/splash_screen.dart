import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 1.0,
              width: screenWidth * 1.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [kMainBackgroundBlueNormal, kMainBackgroundBlueDark],
                  center: Alignment.center,
                  radius: 0.85,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
