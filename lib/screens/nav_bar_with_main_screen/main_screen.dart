import 'package:flutter/material.dart';
import 'package:smiley_toothy/screens/calender_screen/calender_screen.dart';
import 'package:smiley_toothy/screens/home_screen/home_screen.dart';
import 'package:smiley_toothy/screens/nav_bar_with_main_screen/widgets/custom_bottum_nav_bar.dart';


class MainScreenWithNavBar extends StatefulWidget {
  const MainScreenWithNavBar({super.key});

  @override
  State<MainScreenWithNavBar> createState() => _MainScreenWithNavBarState();
}

class _MainScreenWithNavBarState extends State<MainScreenWithNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CalenderScreen(),
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}



