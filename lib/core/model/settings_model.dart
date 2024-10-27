import 'package:hive_flutter/hive_flutter.dart';

part 'settings_model.g.dart';


@HiveType(typeId: 3)
final class SettingsModel {
  @HiveField(0)
  bool showMachinist;
  @HiveField(1)
  bool newUi;
  @HiveField(2)
  int? weekend;
  @HiveField(3)
  Duration? workingHour;

  SettingsModel({
    required this.showMachinist,
    required this.newUi,
    this.weekend,
    this.workingHour
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    showMachinist: json['showMachinist'],
    newUi: json['newUi'],
    weekend: json['weekend'],
    workingHour: json['workingHour']
  );

  Map<String, dynamic> toJson() => {
    "showMachinist": showMachinist,
    "newUi": newUi,
    "weekend": weekend,
    "workingHour": workingHour
  };

}