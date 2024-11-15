// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionStatusAdapter extends TypeAdapter<TransactionStatus> {
  @override
  final int typeId = 2;

  @override
  TransactionStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionStatus.completed;
      case 1:
        return TransactionStatus.pending;
      case 2:
        return TransactionStatus.failed;
      case 3:
        return TransactionStatus.cancelled;
      default:
        return TransactionStatus.completed;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionStatus obj) {
    switch (obj) {
      case TransactionStatus.completed:
        writer.writeByte(0);
        break;
      case TransactionStatus.pending:
        writer.writeByte(1);
        break;
      case TransactionStatus.failed:
        writer.writeByte(2);
        break;
      case TransactionStatus.cancelled:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
