import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smiley_toothy/service/hive_service.dart';

import '../../../models/schedule_model.dart';

class BreathingTooth extends StatefulWidget {
  const BreathingTooth({super.key});

  @override
  State<BreathingTooth> createState() => _BreathingToothState();
}

class _BreathingToothState extends State<BreathingTooth>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  bool showEmojis = false;
  final Random random = Random();
  List<_EmojiParticle> particles = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacity = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  String getToothImage(ScheduleModel schedule) {
    if (!schedule.isEnabled) return 'assets/image/normal.png';
    if (schedule.isCompleted) return 'assets/image/happy.png';
    return 'assets/image/sad.png';
  }

  List<String> getEmojis(ScheduleModel schedule) {
    if (!schedule.isEnabled) return ['🤗', '😊', '✨'];
    if (schedule.isCompleted) return ['❤️', '💖' ];
    return ['😢', '😭', '💧', '🥺'];
  }

  void playEmojiSpray(ScheduleModel schedule) {
    final emojis = getEmojis(schedule);

    particles = List.generate(16, (index) {
      return _EmojiParticle(
        emoji: emojis[random.nextInt(emojis.length)],
        endX: random.nextDouble() * 260 - 190,
        endY: random.nextDouble() * 260 - 190,
        size: random.nextDouble() * 14 + 22,
        paddingLeft: random.nextDouble() * 25,
        paddingTop: random.nextDouble() * 25,
        rotation: random.nextDouble() * 1.5 - 0.75,
      );
    });

    setState(() => showEmojis = true);

    Future.delayed(const Duration(milliseconds: 2300), () {
      if (mounted) setState(() => showEmojis = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final schedules = HivService.getSchedulesForDate(dateKey);
    final schedule = schedules.first;
    final imagePath = getToothImage(schedule);

    return GestureDetector(
      onTap: () => playEmojiSpray(schedule),
      child: SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacity.value,
                  child: Transform.scale(
                    scale: _scale.value,
                    child: child,
                  ),
                );
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Image.asset(
                  imagePath,
                  key: ValueKey(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            if (showEmojis)
              ...particles.map((particle) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    final dx = particle.endX * value;
                    final dy = particle.endY * value;

                    return Positioned(
                      left: 115 + dx + particle.paddingLeft,
                      top: 115 + dy + particle.paddingTop,
                      child: Opacity(
                        opacity: 1 - value,
                        child: Transform.rotate(
                          angle: particle.rotation * value,
                          child: Transform.scale(
                            scale: 0.5 + value,
                            child: Text(
                              particle.emoji,
                              style: TextStyle(
                                fontSize: particle.size,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _EmojiParticle {
  final String emoji;
  final double endX;
  final double endY;
  final double size;
  final double paddingLeft;
  final double paddingTop;
  final double rotation;

  _EmojiParticle({
    required this.emoji,
    required this.endX,
    required this.endY,
    required this.size,
    required this.paddingLeft,
    required this.paddingTop,
    required this.rotation,
  });
}