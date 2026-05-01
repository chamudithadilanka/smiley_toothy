import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class HomeContainerBoxButton extends StatelessWidget {
  const HomeContainerBoxButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:75,
      height: 20,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [kMainBackgroundBlueNormal,kMainBackgroundBlueDark]),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kMainLoadingWhitContainerColor.withOpacity(0.4),width: 2),
        boxShadow: [
          BoxShadow(color: kMainBackgroundBlueDark,spreadRadius: 5,blurRadius: 60)
        ]
      ),
    );
  }
}
