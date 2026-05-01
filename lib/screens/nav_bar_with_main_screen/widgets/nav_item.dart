import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color primaryColor;

  const NavItem({super.key,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        child: Icon(
          icon,
          color: isSelected ? primaryColor : const Color(0xFFBDBDBD),
          size: isSelected ? 36 : 32,
        ),
      ),
    );
  }
}
