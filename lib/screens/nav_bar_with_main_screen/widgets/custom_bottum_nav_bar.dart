import 'package:flutter/material.dart';
import 'package:smiley_toothy/screens/nav_bar_with_main_screen/widgets/nav_item.dart';

import '../../../color_theme/color_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  static const _primaryBlue = Color(0xFF2563EB);
  static const _lightBlue = Color(0xFF60A5FA);
  static const _navBarHeight = 90.0;
  static const _floatingBtnSize = 75.0;
  static const _overlapAmount = 20.0;

  // ✅ Change this to any color you want for the gap background
  static  final Color  _backgroundColor = kMainBackgroundBlueDark;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _backgroundColor, // ← background fills the full SizedBox area
      child: SizedBox(
        height: _navBarHeight + _overlapAmount,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── White bar at the bottom ──
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: _navBarHeight,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 20,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavItem(
                      icon: Icons.home_rounded,
                      index: 0,
                      selectedIndex: selectedIndex,
                      onTap: onItemTapped,
                      primaryColor: _primaryBlue,
                    ),
                    const SizedBox(width: _floatingBtnSize + 16),
                    NavItem(
                      icon: Icons.person_outline_rounded,
                      index: 2,
                      selectedIndex: selectedIndex,
                      onTap: onItemTapped,
                      primaryColor: _primaryBlue,
                    ),
                  ],
                ),
              ),
            ),

            // ── Floating center button ──
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => onItemTapped(1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _floatingBtnSize,
                    height: _floatingBtnSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [_lightBlue, _primaryBlue],
                        center: Alignment.topLeft,
                        radius: 1.4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryBlue.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: _lightBlue.withValues(alpha: 0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                      size: selectedIndex == 1 ? 32 : 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}