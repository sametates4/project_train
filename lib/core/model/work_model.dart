import 'package:hive_flutter/hive_flutter.dart';

part 'work_model.g.dart';

@HiveType(typeId: 1)
final class WorkModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? machinist;
  @HiveField(2)
  final int trainNumber;
  @HiveField(3)
  final int? trainNumberTwo;
  @HiveField(4)
  final DateTime startTime;
  @HiveField(5)
  final DateTime? endTime;
  @HiveField(6)
  final bool? offDay;
  @HiveField(7)
  final bool? weekOfDay;

  WorkModel({
    required this.id,
    this.machinist,
    required this.trainNumber,
    this.trainNumberTwo,
    required this.startTime,
    this.endTime,
    this.offDay,
    this.weekOfDay,
  });

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      id: map['id'] as int,
      machinist: map['machinist'] as String,
      trainNumber: map['trainNumber'] as int,
      trainNumberTwo: map['trainNumberTwo'] as int,
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
      offDay: map['offDay'] as bool,
      weekOfDay: map['weekOfDay'] as bool,
    );
  }

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
    id: json["id"],
    machinist: json["machinist"],
    trainNumber: json["trainNumber"],
    trainNumberTwo: json["trainNumberTwo"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: json["endTime"].toString().isNotEmpty ? DateTime.parse(json["endTime"]) : null,
    offDay: json["offDay"].toString().isNotEmpty ? bool.parse(json["offDay"]) : null,
    weekOfDay: json["weekOfDay"].toString().isNotEmpty ? bool.parse(json["weekOfDay"]) : null
  );

}
