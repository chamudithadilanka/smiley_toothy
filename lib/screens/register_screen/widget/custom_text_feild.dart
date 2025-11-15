import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class CustomTextInputRegisterScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String hintText;

  CustomTextInputRegisterScreen({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
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
          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          labelText: hintText,
          labelStyle: TextStyle(
            color: kMainLoadingIndicatorYellowdark,
                fontWeight: FontWeight.w600
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainLoadingIndicatorYellowdark,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainLoadingIndicatorYellowdark,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
