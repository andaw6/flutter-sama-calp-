import 'package:uuid/uuid.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/utils/other/functions.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'account.g.dart';

@HiveType(typeId: 5)
class Account {

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  double balance;

  @HiveField(3)
  String currency;

  @HiveField(4)
  String qrCode;

  @HiveField(5)
  bool isActive;

  @HiveField(6)
  double plafond;

  @HiveField(7)
  UserInfo? user;

  Account({
    required this.id,
    required this.userId,
    required this.balance,
    required this.currency,
    required this.qrCode,
    required this.isActive,
    required this.plafond,
    this.user
  });

  // Générer un UUID pour chaque nouvel utilisateur
  factory Account.create(String userId, double balance, String currency,
      String qrCode, bool isActive, double plafond) {
    return Account(
      id: const Uuid().v4(), // Génération d'un UUID
      userId: userId,
      balance: balance,
      currency: currency,
      qrCode: qrCode,
      isActive: isActive,
      plafond: plafond,
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userId: json['userId'],
      balance: convertToDouble(json['balance']),
      currency: json['currency'],
      qrCode: json['userId'],
      isActive: json['active'],
      plafond: convertToDouble(json["plafond"]),
      user: json["user"] != null ? UserInfo.fromJson(json["user"]) : null,
    );
  }
}
