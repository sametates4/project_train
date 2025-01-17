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
      machinist: fields[1] as String?,
      trainNumber: fields[2] as int,
      trainNumberTwo: fields[3] as int?,
      startTime: fields[4] as DateTime,
      endTime: fields[5] as DateTime?,
      offDay: fields[6] as bool?,
      weekOfDay: fields[7] as bool?,
      mileageList: (fields[8] as List?)?.cast<MileageCompensationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.machinist)
      ..writeByte(2)
      ..write(obj.trainNumber)
      ..writeByte(3)
      ..write(obj.trainNumberTwo)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.offDay)
      ..writeByte(7)
      ..write(obj.weekOfDay)
      ..writeByte(8)
      ..write(obj.mileageList);
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
