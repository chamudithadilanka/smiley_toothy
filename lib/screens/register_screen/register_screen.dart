import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 100,
            height: 300,
            decoration: BoxDecoration(color: kMainBackgroundBlueDark),
          ),
        ],
      ),
    );
  }
}
