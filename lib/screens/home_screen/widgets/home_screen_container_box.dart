import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

import '../../../custom_widgets/home_container_box_button.dart';

class HomeScreenContainerBoxRight extends StatelessWidget {
  const HomeScreenContainerBoxRight({super.key});

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
              "Brush Expire In:",
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // optional
                    children: [
                      Text(
                        "12:00",
                        style: TextStyle(
                          color: kMainLoadingWhitContainerColor,
                          fontWeight: FontWeight.w600,
                          fontSize: sw * 0.045,
                        ),
                      ),
                      HomeContainerBoxButton(),

                    ],
                  ),
                ),
                Image.asset(
                  "assets/image/brush.png",
                  width: sw * 0.2,
                  height: sh * 0.064,
                  fit: BoxFit.contain,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}