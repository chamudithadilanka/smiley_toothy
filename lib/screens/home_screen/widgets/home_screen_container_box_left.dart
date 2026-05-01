import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import '../../../custom_widgets/home_container_box_button.dart';

class HomeScreenContainerBoxLeft extends StatelessWidget {
  const HomeScreenContainerBoxLeft({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

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
        padding: EdgeInsets.all(sw * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title Row ──────────────────────────────
            Text(
              "Time to Shine:",
              style: TextStyle(
                color: kMainLoadingWhitContainerColor,
                fontWeight: FontWeight.w600,
                fontSize: sw * 0.032,
              ),
            ),

            // ── Time + Image Row ───────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/smile_teeth_with_brush.png",
                  width: sw * 0.2,
                  height: sh * 0.064,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // optional
                    children: [
                      Text(
                        "12:00 PM",
                        style: TextStyle(
                          color: kMainLoadingWhitContainerColor,
                          fontWeight: FontWeight.w600,
                          fontSize: sw * 0.04,
                        ),
                      ),
                      HomeContainerBoxButton(),
                    ],
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