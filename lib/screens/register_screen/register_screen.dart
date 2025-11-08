import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth * 1.0,
            height: screenHeight * 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kMainBackgroundBlueNormal, kMainBackgroundBlueDark],
              ),
            ),
            child: Column(children: []),
          ),
        ],
      ),
    );
  }
}
