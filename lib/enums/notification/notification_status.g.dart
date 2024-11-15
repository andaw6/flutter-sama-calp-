// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationStatusAdapter extends TypeAdapter<NotificationStatus> {
  @override
  final int typeId = 1;

  @override
  NotificationStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationStatus.unread;
      case 1:
        return NotificationStatus.read;
      default:
        return NotificationStatus.unread;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationStatus obj) {
    switch (obj) {
      case NotificationStatus.unread:
        writer.writeByte(0);
        break;
      case NotificationStatus.read:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
