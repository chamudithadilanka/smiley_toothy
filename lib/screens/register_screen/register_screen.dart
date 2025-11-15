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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.09),
                Text(
                  "Create Your Profile",
                  style: TextStyle(
                    color: kMainLoadingIndicatorYellowdark,
                    fontFamily: "Poppins",
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: screenWidth * 0.34,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: kMainLoadingIndicatorYellowdark.withValues(alpha: 0.4),
                          spreadRadius: 9,
                          blurRadius: 3,
                          offset: Offset(1,1 ),
                        ),
                      ],
                      border: Border.all(
                        color: kMainLoadingIndicatorYellowdark,
                        width: 5,
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/image/splash_screen_teeth.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.2,),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
