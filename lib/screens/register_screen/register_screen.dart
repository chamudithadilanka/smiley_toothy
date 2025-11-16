import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import 'package:smiley_toothy/screens/register_screen/widget/custom_button.dart';
import 'package:smiley_toothy/screens/register_screen/widget/custom_text_filed.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                  Image.asset("assets/image/create_account.png", width: 380),
                  SizedBox(height: screenHeight * 0.05),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: screenWidth * 0.44,
                      height: screenHeight * 0.19,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: kMainLoadingWhitContainerColor.withValues(
                              alpha: 0.2,
                            ),
                            spreadRadius: 3,
                            blurRadius: 3,
                          ),
                        ],
                        border: Border.all(
                          color: kMainLoadingIndicatorYellowdark,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/image/splash_screen_teeth.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  CustomTextInputRegisterScreen(
                    hintText: "Enter Your Name",
                    isNumber: false,
                    isHintText: true,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: screenWidth*0.05,),
                        Text(
                          "Enter Your Age : ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: kMainLoadingIndicatorYellowdark,
                          ),
                        ),
                        Flexible(
                          child: CustomTextInputRegisterScreen(
                            isHintText: false,
                            hintText: "",
                            isNumber: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInputRegisterScreen(
                    hintText: "Enter Your Email",
                    isNumber: false,
                    isHintText: true,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInputRegisterScreen(
                    hintText: "Enter Your Email",
                    isNumber: false,
                    isHintText: true,
                  ),
                  SizedBox(height: screenHeight * 0.11),
                  CustomButtonRegister(),
                  //time day and night
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.61,
              right: screenWidth * 0.31,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kMainLoadingWhitContainerColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: kMainLoadingIndicatorYellowdark,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
