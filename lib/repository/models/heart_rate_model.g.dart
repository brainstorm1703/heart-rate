// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_rate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeartRateModelAdapter extends TypeAdapter<HeartRateModel> {
  @override
  final int typeId = 1;

  @override
  HeartRateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeartRateModel(
      systolic: fields[1] as int,
      diastolic: fields[2] as int,
      pulse: fields[3] as int,
      date: fields[4] as String,
      time: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HeartRateModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.systolic)
      ..writeByte(2)
      ..write(obj.diastolic)
      ..writeByte(3)
      ..write(obj.pulse)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
