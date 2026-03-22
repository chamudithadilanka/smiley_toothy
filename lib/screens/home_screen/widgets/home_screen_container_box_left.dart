import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class HomeScreenContainerBoxLeft extends StatelessWidget {
  const HomeScreenContainerBoxLeft({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width; // screen width
    final sh = size.height; // screen height
    return Container(
      width: sw * 0.430,
      height: sh * 0.120,
      decoration: BoxDecoration(
        border: Border.all(color: kMainLoadingWhitContainerColor, width: 3),
        borderRadius: BorderRadius.circular(10),
        color: kMainLoadingWhitContainerColor.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: kMainLoadingWhitContainerColor.withOpacity(0.15),
            blurRadius: 25,
            spreadRadius: 5,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Time To Shine : ",
                  style: TextStyle(
                    color: kMainLoadingWhitContainerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
