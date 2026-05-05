import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final DateTime _today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late final ScrollController _scrollController;

  // Generate all days of the current month
  List<DateTime> _getMonthDays() {
    final firstDay = DateTime(_today.year, _today.month, 1);
    final lastDay = DateTime(_today.year, _today.month + 1, 0);
    return List.generate(
      lastDay.day,
          (i) => firstDay.add(Duration(days: i)),
    );
  }

  String _getDayName(DateTime date) {
    const days = ['sun', 'mon', 'tue', 'wed', 'thur', 'fri', 'sat'];
    return days[date.weekday % 7];
  }

  String _getMonthName(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[date.month - 1];
  }

  bool _isSelected(DateTime date) =>
      date.year == _selectedDay.year &&
          date.month == _selectedDay.month &&
          date.day == _selectedDay.day;

  bool _isToday(DateTime date) =>
      date.year == _today.year &&
          date.month == _today.month &&
          date.day == _today.day;

  @override
  void initState() {
    super.initState();
    final offset = (_today.day - 1) * 76.0;
    _scrollController = ScrollController(initialScrollOffset: offset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monthDays = _getMonthDays();

    return Scaffold(
      body: Column(
        children: [
          // ── Top white calendar strip ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
                top: 56, left: 10, right: 10, bottom: 24),
            decoration: BoxDecoration(
              color: kMainLoadingWhitContainerColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month + Year + "+" button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_getMonthName(_today)} ${_today.year}',
                        style: TextStyle(
                          color: kMainBackgroundBlueDark,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kMainBackgroundBlueDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Horizontally Scrollable Day Strip ──
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: monthDays.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final date = monthDays[index];
                      final selected = _isSelected(date);
                      final today = _isToday(date);

                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedDay = date);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 58,
                          height: 72,
                          decoration: BoxDecoration(
                            color: selected
                                ? kMainBackgroundBlueDark
                                : kMainBackgroundBlueNormal.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: selected
                                  ? kMainBackgroundBlueNormal
                                  : kMainBackgroundBlueNormal.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _getDayName(date),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: selected || today
                                      ? FontWeight.bold
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom gradient container ──
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                gradient: RadialGradient(
                  colors: [
                    kMainBackgroundBlueNormal,
                    kMainBackgroundBlueDark,
                    kMainBackgroundBlueDark,
                  ],
                  radius: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Center(
                child: Text(
                  'Selected: ${_selectedDay.day} ${_getMonthName(_selectedDay)} ${_selectedDay.year}',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}