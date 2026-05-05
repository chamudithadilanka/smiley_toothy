import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ScheduleModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String time;

  @HiveField(2)
  late int durationMinutes;

  @HiveField(3)
  late bool isEnabled;

  @HiveField(4)
  late String dateKey;

  ScheduleModel({
    required this.title,
    required this.time,
    required this.durationMinutes,
    required this.isEnabled,
    required this.dateKey,
  });
}
