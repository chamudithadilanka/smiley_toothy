import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class CustomTextInputRegisterScreen extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isNumber;
  final bool isHintText;
  final double boarderRadius;

  CustomTextInputRegisterScreen({
    super.key,
    required this.hintText,
    required this.isNumber,
    required this.isHintText,
    required this.boarderRadius,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: screenWidth * 0.9,
        child: Container(
          width: screenWidth * 1.0,
          height: screenHeight * 0.065,
          decoration: BoxDecoration(
            color: kMainBackgroundBlueNormal,
            borderRadius: BorderRadius.circular(boarderRadius),

            boxShadow: [
              BoxShadow( color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 1),
                blurRadius: 10,),
            ],
          ),
          child: TextFormField(
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            inputFormatters:
                isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
            controller: controller,
            cursorRadius: Radius.circular(100),
            style: TextStyle(
              color: kMainLoadingIndicatorYellowdark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            cursorWidth: 4,
            cursorColor: kMianLoadingIndicatorYellowNormal,
            cursorErrorColor: Colors.red,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              labelText: isHintText ? hintText : null,
              labelStyle: TextStyle(
                color: kMainLoadingWhitContainerColor.withValues(alpha: 0.6),
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kMainLoadingIndicatorYellowdark,
                  width: 3.2,
                ),
                borderRadius: BorderRadius.circular(boarderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kMainLoadingIndicatorYellowdark,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
