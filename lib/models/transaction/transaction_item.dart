// Classe TransactionItem qui hérite de TransactionBase
import 'package:wave_odc/enums/transaction/transaction_status.dart';
import 'package:wave_odc/enums/transaction/transaction_type.dart';
import 'package:wave_odc/models/transaction/transaction_base.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'transaction_item.g.dart';


@HiveType(typeId: 12)
class TransactionItem extends TransactionBase {

  @HiveField(7)
  final UserInfo? user;

  TransactionItem({
    required super.id, // Super parameters for the parent class fields
    required super.amount,
    required super.feeAmount,
    required super.currency,
    required super.type,
    required super.status,
    required super.createdAt,
    this.user,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'],
      amount: json['amount'].toDouble(),
      feeAmount: json['feeAmount'].toDouble(),
      currency: json['currency'],
      type:
          TransactionTypeExtension.fromString(json['type']),
      status: TransactionStatusExtension.fromString(json['status']),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
    );
  }
}
