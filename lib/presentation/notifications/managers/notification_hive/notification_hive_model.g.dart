// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationHiveModelAdapter extends TypeAdapter<NotificationHiveModel> {
  @override
  final int typeId = 7;

  @override
  NotificationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
      type: fields[3] as String,
      read: fields[4] as bool,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.read)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
