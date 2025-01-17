// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mileage_compensation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MileageCompensationModelAdapter
    extends TypeAdapter<MileageCompensationModel> {
  @override
  final int typeId = 4;

  @override
  MileageCompensationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MileageCompensationModel(
      startStation: fields[0] as String,
      endStation: fields[1] as String?,
      intermediateStation: fields[2] as String?,
      startTime: fields[3] as DateTime,
      endTime: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MileageCompensationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.startStation)
      ..writeByte(1)
      ..write(obj.endStation)
      ..writeByte(2)
      ..write(obj.intermediateStation)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MileageCompensationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
