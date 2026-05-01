import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import 'package:smiley_toothy/screens/nav_bar_with_main_screen/main_screen.dart';
import 'package:smiley_toothy/screens/register_screen/widget/custom_button.dart';
import 'package:smiley_toothy/screens/register_screen/widget/custom_text_filed.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectGender;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight * 1.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [kMainBackgroundBlueNormal, kMainBackgroundBlueDark],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.08),
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
                  boarderRadius: 35,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextInputRegisterScreen(
                  hintText: "Enter Your Email",
                  isNumber: false,
                  isHintText: true,
                  boarderRadius: 35,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.07),
                    Text(
                      "Enter Your Age : ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kMainLoadingIndicatorYellowdark,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: screenWidth * 0.0,
                        child: CustomTextInputRegisterScreen(
                          isHintText: true,
                          hintText: "ex - 15",
                          isNumber: true,
                          boarderRadius: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: screenWidth * 0.07),
                    Text(
                      "Select Gender  : ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kMainLoadingIndicatorYellowdark,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: SizedBox(
                        width: screenWidth * 0.04,
                        child: DropdownButtonFormField<String>(
                          value: selectGender,
                          hint: Text(
                            "Select",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(
                            color: kMainLoadingWhitContainerColor.withValues(
                              alpha: 0.6,
                            ),
                            fontSize: 18,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainLoadingIndicatorYellowdark,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainLoadingIndicatorYellowdark,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          items: ["Male", "Female"].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: kMainLoadingIndicatorYellowdark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectGender = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                  ],
                ),
                SizedBox(height: screenHeight * 0.11),
                CustomButtonRegister(
                  onPress: () {
                    Navigator.pushReplacement( // ✅ pushReplacement so back button won't return to register
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreenWithNavBar(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}