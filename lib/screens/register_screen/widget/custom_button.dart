import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class CustomButtonRegister extends StatelessWidget {
  final VoidCallback onPress;
  const CustomButtonRegister({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        color: kMainLoadingWhitContainerColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: kMainLoadingWhitContainerColor.withValues(alpha: 0.2),
          blurRadius: 4,
            spreadRadius: 4,
          )
        ],
        border: Border.all(color: kMainLoadingWhitContainerColor, width: 3),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPress,
        child: Text(
          "Submit",
          style: TextStyle(
            fontSize: 25,
            color: kMainLoadingWhitContainerColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
