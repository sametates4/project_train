import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
final class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int kky;
  @HiveField(2)
  String lastBackup;

  UserModel({
    required this.name,
    required this.kky,
    required this.lastBackup,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    kky: json["kky"],
    lastBackup: json["last_backup"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "kky": kky,
    "last_backup": lastBackup,
  };
}
