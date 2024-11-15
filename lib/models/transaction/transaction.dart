import 'package:wave_odc/enums/transaction/transaction_status.dart';
import 'package:wave_odc/enums/transaction/transaction_type.dart';
import 'package:wave_odc/models/credit_purchase/credit_purchase.dart';
import 'package:wave_odc/models/transaction/transaction_base.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/utils/other/functions.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction.g.dart';

@HiveType(typeId: 13)
class Transaction extends TransactionBase {

  @HiveField(7)
  final UserInfo? sender;

  @HiveField(8)
  final UserInfo? receiver;

  @HiveField(9)
  final CreditPurchase? creditPurchase;

  Transaction({
    this.sender,
    this.receiver,
    this.creditPurchase,
    required super.id, // Super parameters for the parent class fields
    required super.amount,
    required super.feeAmount,
    required super.currency,
    required super.type,
    required super.status,
    required super.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: convertToDouble(json['amount']),
      feeAmount: convertToDouble(json['feeAmount']),
      currency: json['currency'],
      type:
          TransactionTypeExtension.fromString(json['type']),
      status: TransactionStatusExtension.fromString(json['status']),
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json['createdAt']).toUtc()
          : DateTime.now(),
      sender: json['sender'] != null ? UserInfo.fromJson(json['sender']) : null,
      receiver:
          json['receiver'] != null ? UserInfo.fromJson(json['receiver']) : null,
      creditPurchase: json['creditPurchase'] != null
          ? CreditPurchase.fromJson(json['creditPurchase'])
          : null,
    );
  }
}
