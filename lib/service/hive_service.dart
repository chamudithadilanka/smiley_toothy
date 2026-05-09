import 'package:hive_flutter/hive_flutter.dart';
import '../models/schedule_model.dart';
import '../models/user_model.dart';

class HivService {
  static const String _userbox = 'userBox';
  static const String _scheduleBox = 'scheduleBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ScheduleModelAdapter());
    await Hive.openBox<UserModel>(_userbox);
    await Hive.openBox<ScheduleModel>(_scheduleBox);
  }

  // user
  static Box<UserModel> get userBox => Hive.box<UserModel>(_userbox);

  static void saveUser(UserModel user){
    userBox.put('currentUser', user);
  }

  static UserModel? getUser()  => userBox.get('currentUser');
  static bool isRegistered() => userBox.containsKey('currentUser');

  static Box<ScheduleModel> get scheduleBox =>
      Hive.box<ScheduleModel>(_scheduleBox);

  // Get or create default schedules for a specific date
  static List<ScheduleModel> getSchedulesForDate(String dateKey) {
    final all = scheduleBox.values
        .where((s) => s.dateKey == dateKey)
        .toList();

    if (all.isEmpty) {
      // Create default Morning + Night for that day
      final morning = ScheduleModel(
        title: 'Morning',
        time: '07:00 AM',
        durationMinutes: 2,
        isEnabled: true,
        dateKey: dateKey,
      );
      final night = ScheduleModel(
        title: 'Night',
        time: '09:00 PM',
        durationMinutes: 2,
        isEnabled: true,
        dateKey: dateKey,
      );
      scheduleBox.add(morning);
      scheduleBox.add(night);
      return [morning, night];
    }

    return all;
  }

  static void updateSchedule(ScheduleModel schedule) {
    schedule.save(); // HiveObject .save() updates in place
  }
}
