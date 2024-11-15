    // Classe de base pour les transactions
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wave_odc/enums/transaction/transaction_status.dart';
import 'package:wave_odc/enums/transaction/transaction_type.dart';


part 'transaction_base.g.dart';


@HiveType(typeId: 11)
class TransactionBase {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final double feeAmount;

  @HiveField(3)
  final String currency;

  @HiveField(4)
  final TransactionType type;

  @HiveField(5)
  final TransactionStatus status;

  @HiveField(6)
  final DateTime? createdAt;

  TransactionBase({
    required this.id,
    required this.amount,
    required this.feeAmount,
    required this.currency,
    required this.type,
    required this.status,
    this.createdAt
  });

  factory TransactionBase.fromJson(Map<String, dynamic> json) {
    return TransactionBase(
      id: json['id'],
      amount: json['amount'].toDouble(),
      feeAmount: json['feeAmount'].toDouble(),
      currency: json['currency'],
      type: json['type'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }
}
