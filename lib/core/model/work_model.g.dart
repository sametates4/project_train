// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkModelAdapter extends TypeAdapter<WorkModel> {
  @override
  final int typeId = 1;

  @override
  WorkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkModel(
      id: fields[0] as int,
      machinistOne: fields[1] as String,
      machinistTwo: fields[2] as String,
      trainNumber: fields[3] as int,
      startTime: fields[4] as String,
      finishTime: fields[5] as String,
      exitStation: fields[6] as String,
      arrivalStation: fields[7] as String,
      dayOfTime: fields[8] as DateTime,
      offDay: fields[9] as bool,
      weekOfDay: fields[10] as bool,
      machinistOneNumber: fields[11] as int,
      machinistTwoNumber: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.machinistOne)
      ..writeByte(2)
      ..write(obj.machinistTwo)
      ..writeByte(3)
      ..write(obj.trainNumber)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.finishTime)
      ..writeByte(6)
      ..write(obj.exitStation)
      ..writeByte(7)
      ..write(obj.arrivalStation)
      ..writeByte(8)
      ..write(obj.dayOfTime)
      ..writeByte(9)
      ..write(obj.offDay)
      ..writeByte(10)
      ..write(obj.weekOfDay)
      ..writeByte(11)
      ..write(obj.machinistOneNumber)
      ..writeByte(12)
      ..write(obj.machinistTwoNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
