import 'package:uuid/uuid.dart';
import 'package:wave_odc/enums/user/user_role.dart';
import 'package:wave_odc/models/account/account.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 15)
class User {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  bool isActive;

  @HiveField(5)
  String role;

  @HiveField(6)
  Account account;

  User({
    required this.id,
    required this.name,
    this.email,
    required this.phoneNumber,
    required this.isActive,
    required this.role,
    required this.account,
  });

  factory User.create(String name, String? email, String phoneNumber,
      bool isActive, String role, Account account) {
    return User(
      id: const Uuid().v4(),
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      isActive: isActive,
      role: role,
      account: account,
    );
  }

  // Ajouter une méthode 'fromJson' pour convertir le JSON en objet 'User'
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      isActive: json['active'] as bool,
      role: json['role'] as String,
      account: Account.fromJson(json['account'] as Map<String, dynamic>)
    );
  }

  static User defaultUser() {
    return User.create(
        "Andaw Ciss",
        "cissandaw@gmail.com",
        "778133537",
        true,
        UserRole.client.name,
        Account.create("userId", 1000, "XOR", "", true, 10000));
  }
}
