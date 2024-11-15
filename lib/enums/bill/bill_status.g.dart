// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillStatusAdapter extends TypeAdapter<BillStatus> {
  @override
  final int typeId = 0;

  @override
  BillStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BillStatus.pending;
      case 1:
        return BillStatus.paid;
      case 2:
        return BillStatus.overdue;
      default:
        return BillStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, BillStatus obj) {
    switch (obj) {
      case BillStatus.pending:
        writer.writeByte(0);
        break;
      case BillStatus.paid:
        writer.writeByte(1);
        break;
      case BillStatus.overdue:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
