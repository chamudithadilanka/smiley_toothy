import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import 'package:smiley_toothy/screens/home_screen/widgets/home_screen_container_box.dart';
import 'package:smiley_toothy/screens/home_screen/widgets/home_screen_container_box_left.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d').format(now);

    // ── Responsive helpers ──────────────────────────────────────────
    final size = MediaQuery.of(context).size;
    final sw = size.width; // screen width
    final sh = size.height; // screen height
    final isTablet = sw >= 600; // simple tablet breakpoint

    final iconSize = sw * 0.1; // ~36px on a 400px-wide phone
    final avatarSize = sw * 0.14; // ~60px on a 400px-wide phone
    final fontSize = isTablet ? 22.0 : sw * 0.048;
    final padAll = sw * 0.05;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [kMainBackgroundBlueNormal, kMainBackgroundBlueDark,kMainBackgroundBlueDark],
            radius: BorderSide.strokeAlignOutside,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(padAll),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ── Avatar ─────────────────────────────────────
                    Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        color: kMainLoadingWhitContainerColor,
                        borderRadius: BorderRadius.circular(avatarSize / 1),
                      ),
                      child: Image.asset(
                        'assets/image/splash_screen_teeth.png',
                      ),
                    ),

                    SizedBox(width: sw * 0.03),

                    // ── Date (takes remaining space) ────────────────
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: sh * 0.025),
                          Text(
                            formattedDate,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kMainLoadingWhitContainerColor,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/image/hello.png',
                                width: sw * 0.12,
                              ),
                              Text(
                                ",  Chamuditha",
                                style: TextStyle(
                                  color: kMainLoadingIndicatorYellowdark,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: sw * 0.03),

                    // ── Notification icon ───────────────────────────
                    Icon(
                      Icons.notifications,
                      color: kMainLoadingWhitContainerColor,
                      size: iconSize,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(padAll),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [HomeScreenContainerBoxLeft(),HomeScreenContainerBoxRight()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
