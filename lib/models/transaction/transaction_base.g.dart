// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionBaseAdapter extends TypeAdapter<TransactionBase> {
  @override
  final int typeId = 11;

  @override
  TransactionBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionBase(
      id: fields[0] as String,
      amount: fields[1] as double,
      feeAmount: fields[2] as double,
      currency: fields[3] as String,
      type: fields[4] as TransactionType,
      status: fields[5] as TransactionStatus,
      createdAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionBase obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.feeAmount)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
