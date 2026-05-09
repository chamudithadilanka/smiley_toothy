import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smiley_toothy/models/schedule_model.dart';
import 'package:smiley_toothy/service/hive_service.dart';

class BrushingTimerCard extends StatefulWidget {
  final ScheduleModel schedule;
  final VoidCallback? onChanged;

  const BrushingTimerCard({
    super.key,
    required this.schedule,
    this.onChanged,
  });

  @override
  State<BrushingTimerCard> createState() => _BrushingTimerCardState();
}

class _BrushingTimerCardState extends State<BrushingTimerCard> {
  Timer? _timer;
  late int _totalSeconds;
  late int _remainingSeconds;
  bool _isRunning = false;

  Color get _cardColor =>
      _isMorning ? const Color(0xFF4DC8F5) : const Color(0xFF6C63FF);

  Color get _shadowColor => _isMorning
      ? const Color(0xFF4DC8F5).withOpacity(0.4)
      : const Color(0xFF6C63FF).withOpacity(0.4);

  bool get _isMorning => widget.schedule.title == 'Morning';

  // ── Read completion directly from Hive model ──
  bool get _isCompleted => widget.schedule.isCompleted;

  @override
  void initState() {
    super.initState();
    _resetTimer();
    // If already completed, show full progress
    if (_isCompleted) {
      _remainingSeconds = 0;
    }
  }

  void _resetTimer() {
    _totalSeconds     = widget.schedule.durationMinutes * 60;
    _remainingSeconds = _totalSeconds;
  }

  void _startStop() {
    // ── Block if already completed ──
    if (_isCompleted) return;

    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      if (_remainingSeconds == 0) _resetTimer();
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_remainingSeconds > 0) {
          setState(() => _remainingSeconds--);
        } else {
          _timer?.cancel();
          setState(() => _isRunning = false);
          _markCompleted();
        }
      });
    }
  }

  void _markCompleted() {
    widget.schedule.isCompleted = true;
    HivService.updateSchedule(widget.schedule);
    widget.onChanged?.call();
    setState(() {}); // rebuild to show completed button

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🎉 Great job!'),
        content: Text(
          'You finished your ${widget.schedule.title.toLowerCase()} brushing!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime() async {
    if (_isCompleted) return; // can't change time after completion
    try {
      final rawTime  = widget.schedule.time.trim();
      final spaceIdx = rawTime.lastIndexOf(' ');
      final timePart = spaceIdx != -1
          ? rawTime.substring(0, spaceIdx).trim()
          : rawTime;
      final periodPart = spaceIdx != -1
          ? rawTime.substring(spaceIdx + 1).trim().toUpperCase()
          : '';
      final colonIdx = timePart.indexOf(':');
      int hour       = int.parse(colonIdx != -1
          ? timePart.substring(0, colonIdx)
          : timePart);
      int minute     = int.parse(colonIdx != -1
          ? timePart.substring(colonIdx + 1)
          : '0');
      final isPm = periodPart == 'PM';
      if (isPm && hour != 12) hour += 12;
      if (!isPm && hour == 12) hour = 0;
      hour   = hour.clamp(0, 23);
      minute = minute.clamp(0, 59);

      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: hour, minute: minute),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _cardColor,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        ),
      );

      if (picked != null && mounted) {
        setState(() => widget.schedule.time = _formatTimeOfDay(picked));
        HivService.updateSchedule(widget.schedule);
        widget.onChanged?.call();
      }
    } catch (_) {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null && mounted) {
        setState(() => widget.schedule.time = _formatTimeOfDay(picked));
        HivService.updateSchedule(widget.schedule);
        widget.onChanged?.call();
      }
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final period  = time.period == DayPeriod.am ? 'AM' : 'PM';
    final hour    = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute  = time.minute.toString().padLeft(2, '0');
    final hourStr = hour.toString().padLeft(2, '0');
    return '$hourStr:$minute $period';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerDisplay {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}';
  }

  double get _progress => _isCompleted
      ? 1.0 // full bar when completed
      : (_totalSeconds == 0
      ? 0
      : 1 - (_remainingSeconds / _totalSeconds));

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 150,
      decoration: BoxDecoration(
        // ── Card dims slightly when completed ──
        color: _isCompleted
            ? _cardColor.withOpacity(0.75)
            : _cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _isCompleted
                ? Colors.green.withOpacity(0.3)
                : _shadowColor,
            blurRadius: _isCompleted ? 20 : 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Icon pops out top-left ──
          Positioned(
            left: -20,
            top: -60,
            bottom: 60,
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    _isMorning
                        ? 'assets/image/sun.png'
                        : 'assets/image/moon.png',
                    width: 80,
                    height: 80,
                  ),
                  // ── Green tick overlay on icon when completed ──
                  if (_isCompleted)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Card content ──
          Padding(
            padding: const EdgeInsets.only(
                left: 72, right: 16, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Row 1: Title + badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Brushing Timer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    // ── Badge changes to "Done" when completed ──
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: _isCompleted
                            ? Colors.green.withOpacity(0.85)
                            : Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isCompleted) ...[
                            const Icon(Icons.check_circle,
                                color: Colors.white, size: 11),
                            const SizedBox(width: 3),
                          ],
                          Text(
                            _isCompleted
                                ? 'Done'
                                : (_isMorning ? 'Day' : 'Night'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Row 2: Timer display
                Text(
                  _isCompleted ? '00 : 00' : _timerDisplay,
                  style: TextStyle(
                      color: _isCompleted
                          ? Colors.white.withOpacity(0.6)
                          : Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),

                // Row 3: Progress bar — full green when completed
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isCompleted
                          ? Colors.greenAccent.shade400
                          : const Color(0xFFE8D44D),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Row 4: Time + button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Time label (no edit icon when completed)
                    GestureDetector(
                      onTap: _isRunning || _isCompleted ? null : _pickTime,
                      child: Row(
                        children: [
                          Text(
                            widget.schedule.time,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                          if (!_isCompleted) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.edit,
                              color: Colors.white
                                  .withOpacity(_isRunning ? 0.2 : 0.7),
                              size: 13,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // ── Completed button (green, locked) ──
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                        color: _isCompleted
                            ? Colors.greenAccent.shade400
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: _isCompleted
                            ? [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ]
                            : [],
                      ),
                      child: GestureDetector(
                        onTap: _isCompleted ? null : _startStop,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isCompleted)
                              const Icon(Icons.check,
                                  color: Colors.white, size: 14),
                            if (_isCompleted) const SizedBox(width: 4),
                            Text(
                              _isCompleted
                                  ? 'Completed'
                                  : (_isRunning ? 'Stop' : 'Start'),
                              style: TextStyle(
                                  color: _isCompleted
                                      ? Colors.white
                                      : _cardColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}