import 'package:hive_flutter/hive_flutter.dart';

part 'work_model.g.dart';

@HiveType(typeId: 1)
final class WorkModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String machinistOne;
  @HiveField(2)
  final String machinistTwo;
  @HiveField(3)
  final int trainNumber;
  @HiveField(4)
  final String startTime;
  @HiveField(5)
  final String finishTime;
  @HiveField(6)
  final String exitStation;
  @HiveField(7)
  final String arrivalStation;
  @HiveField(8)
  final DateTime dayOfTime;
  @HiveField(9)
  final bool offDay;
  @HiveField(10)
  final bool weekOfDay;
  @HiveField(11)
  final int machinistOneNumber;
  @HiveField(12)
  final int machinistTwoNumber;

  WorkModel({
      required this.id,
      required this.machinistOne,
      required this.machinistTwo,
      required this.trainNumber,
      required this.startTime,
      required this.finishTime,
      required this.exitStation,
      required this.arrivalStation,
      required this.dayOfTime,
      required this.offDay,
      required this.weekOfDay,
      required this.machinistOneNumber,
      required this.machinistTwoNumber
      });

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      id: map['id'] as int,
      machinistOne: map['machinistOne'] as String,
      machinistTwo: map['machinistTwo'] as String,
      trainNumber: map['trainNumber'] as int,
      startTime: map['startTime'] as String,
      finishTime: map['finishTime'] as String,
      exitStation: map['exitStation'] as String,
      arrivalStation: map['arrivalStation'] as String,
      dayOfTime: map['dayOfTime'] as DateTime,
      offDay: map['offDay'] as bool,
      weekOfDay: map['weekOfDay'] as bool,
      machinistOneNumber: map['machinistOneNumber'] as int,
      machinistTwoNumber: map['machinistTwoNumber'] as int,
    );
  }

}
