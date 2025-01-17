import 'package:hive_flutter/hive_flutter.dart';

part 'mileage_compensation_model.g.dart';

@HiveType(typeId: 4)
final class MileageCompensationModel {
  @HiveField(0)
  final String startStation;
  @HiveField(1)
  final String? endStation;
  @HiveField(2)
  final String? intermediateStation;
  @HiveField(3)
  final DateTime startTime;
  @HiveField(4)
  final DateTime? endTime;

  MileageCompensationModel({
    required this.startStation,
    this.endStation,
    this.intermediateStation,
    required this.startTime,
    this.endTime
  });

  factory MileageCompensationModel.fromMap(Map<String, dynamic> map) {
    return MileageCompensationModel(
        startStation: map['startStation'] as String,
        endStation: map['endStation'] as String,
        intermediateStation: map['intermediateStation'] as String,
        startTime: map['startTime'] as DateTime,
        endTime: map['endTime'] as DateTime
    );
  }

  factory MileageCompensationModel.fromJson(Map<String, dynamic> json) {
    return MileageCompensationModel(
        startStation: json['startStation'],
        endStation: json['endStation'],
        intermediateStation: json['intermediateStation'],
        startTime: json['startTime'],
        endTime: json['endTime']
    );
  }
}