import 'package:hive_flutter/adapters.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 5; // Put an ID you didn't use yet.

  @override
  Duration read(BinaryReader reader) {
    return Duration(milliseconds: reader.readInt());
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inMilliseconds);
  }
}