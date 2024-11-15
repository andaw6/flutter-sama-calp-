import 'package:uuid/uuid.dart';
import 'package:wave_odc/enums/bill/bill_status.dart';
import 'package:wave_odc/models/company/company.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/utils/other/functions.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'bill.g.dart';

@HiveType(typeId: 6)
class Bill {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String currency;

  @HiveField(4)
  BillStatus status;

  @HiveField(5)
  Company? company;

  @HiveField(6)
  UserInfo? user;

  @HiveField(7)
  DateTime createdAt;

  Bill({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.company,
    this.user
  });

  // Générer un UUID pour chaque nouvel objet Bill
  factory Bill.create(String userId, String companyId, double amount,
      String currency, BillStatus status) {
    return Bill(
        id: const Uuid().v4(),
        userId: userId,
        amount: amount,
        currency: currency,
        status: status,
        createdAt: DateTime.now()
    );
  }

  // Méthode fromJson pour la désérialisation d'un JSON
  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      userId: json['userId'],
      amount: convertToDouble(json['amount']),
      currency: json['currency'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']).toUtc() : DateTime.now(),
      status: BillStatusExtension.fromString(json['status']),
      company: json['company'] != null ? Company.fromJson(json['company']) : null, // Si la société est incluse
      user: json["user"] != null ? UserInfo.fromJson(json["user"]) : null,
    );
  }
}
