import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import 'package:smiley_toothy/screens/calender_screen/widgets/schedule_card.dart';
import 'package:smiley_toothy/service/hive_service.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final DateTime _today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late final ScrollController _scrollController;

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

  List<DateTime> _getMonthDays() {
    final firstDay = DateTime(_today.year, _today.month, 1);
    final lastDay = DateTime(_today.year, _today.month + 1, 0);
    return List.generate(lastDay.day, (i) => firstDay.add(Duration(days: i)));
  }

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _getDayName(DateTime date) {
    const days = ['sun', 'mon', 'tue', 'wed', 'thur', 'fri', 'sat'];
    return days[date.weekday % 7];
  }

  String _getMonthName(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[date.month - 1];
  }

  bool _isSelected(DateTime date) => _dateKey(date) == _dateKey(_selectedDay);
  bool _isToday(DateTime date) => _dateKey(date) == _dateKey(_today);

  bool _isFuture(DateTime date) {
    final todayOnly = DateTime(_today.year, _today.month, _today.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isAfter(todayOnly);
  }

  _DayStatus _getDayStatus(DateTime date) {
    if (_isFuture(date)) return _DayStatus.none;

    final schedules = HivService.getSchedulesForDate(_dateKey(date));
    if (schedules.isEmpty) return _DayStatus.none;

    final enabled = schedules.where((s) => s.isEnabled).toList();
    final completed = enabled.where((s) => s.isCompleted).toList();

    if (enabled.isEmpty) return _DayStatus.none;
    if (completed.isEmpty) return _DayStatus.none;
    if (completed.length == enabled.length) return _DayStatus.full;

    return _DayStatus.partial;
  }

  @override
  Widget build(BuildContext context) {
    final monthDays = _getMonthDays();
    final schedules = HivService.getSchedulesForDate(_dateKey(_selectedDay));

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.only(top: 56, left: 10, right: 10, bottom: 24),
            color: kMainLoadingWhitContainerColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      InkWell(
                        onTap: () {},
                        child: Container(
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
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 85,
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
                      final status = _getDayStatus(date);
                      final isFuture = _isFuture(date);

                      return GestureDetector(
                        onTap: isFuture
                            ? null
                            : () {
                          setState(() {
                            _selectedDay = date;
                          });
                        },
                        child: Opacity(
                          opacity: isFuture ? 0.45 : 1.0,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 58,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: isFuture
                                      ? Colors.grey.withOpacity(0.4)
                                      : selected
                                      ? kMainBackgroundBlueDark
                                      : kMainBackgroundBlueNormal
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: isFuture
                                        ? Colors.grey.withOpacity(0.3)
                                        : selected
                                        ? kMainBackgroundBlueNormal
                                        : kMainBackgroundBlueNormal
                                        .withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _getDayName(date),
                                      style: TextStyle(
                                        color: isFuture
                                            ? Colors.white.withOpacity(0.4)
                                            : Colors.white.withOpacity(0.85),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: isFuture
                                            ? Colors.white.withOpacity(0.4)
                                            : Colors.white,
                                        fontSize: 20,
                                        fontWeight: selected || today
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (!isFuture && status != _DayStatus.none)
                                Positioned(
                                  top: -6,
                                  right: -6,
                                  child: Container(
                                    width: 20,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: status == _DayStatus.full
                                          ? Colors.greenAccent.shade400
                                          : Colors.orangeAccent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      status == _DayStatus.full
                                          ? Icons.check
                                          : Icons.remove,
                                      size: 12,
                                      color: Colors.white,
                                    ),
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
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Your Schedule',
                    style: TextStyle(
                      color: kMainLoadingWhitContainerColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Selected: ${_selectedDay.day} ${_getMonthName(_selectedDay)} ${_selectedDay.year}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (_, i) => Column(
                        children: [
                          const SizedBox(height: 10),
                          BrushingTimerCard(
                            schedule: schedules[i],
                            onChanged: () => setState(() {}),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _DayStatus { none, partial, full }