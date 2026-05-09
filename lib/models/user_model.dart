import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late int age;

  @HiveField(3)
  late String gender;

  UserModel({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
  });
}
