// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_purchase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditPurchaseAdapter extends TypeAdapter<CreditPurchase> {
  @override
  final int typeId = 9;

  @override
  CreditPurchase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditPurchase(
      receiverName: fields[0] as String,
      receiverPhoneNumber: fields[1] as String,
      receiverEmail: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CreditPurchase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.receiverName)
      ..writeByte(1)
      ..write(obj.receiverPhoneNumber)
      ..writeByte(2)
      ..write(obj.receiverEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditPurchaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
