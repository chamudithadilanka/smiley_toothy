import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class CustomButtonRegister extends StatelessWidget {
  const CustomButtonRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        color: kMainLoadingWhitContainerColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kMainLoadingIndicatorYellowdark, width: 3),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {},
        child: Text(
          "Register",
          style: TextStyle(
            fontSize: 26,
            color: kMainLoadingWhitContainerColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
