import 'package:uuid/uuid.dart';

import 'package:hive_flutter/hive_flutter.dart';


part 'user_info.g.dart';

@HiveType(typeId: 14)
class UserInfo {
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

  UserInfo({
    required this.id,
    required this.name,
    this.email,
    required this.phoneNumber,
    required this.isActive,
    required this.role,
  });

  // Générer un UUID pour chaque nouvel utilisateur
  factory UserInfo.create(String name, String email, String password,
      String phoneNumber, bool isActive, String role) {
    return UserInfo(
      id: const Uuid().v4(), // Génération d'un UUID
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      isActive: isActive,
      role: role,
    );
  }
  // Ajouter une méthode 'fromJson' pour convertir le JSON en objet 'User'
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      isActive: json['active'],
      role: json['role'],
    );
  }
}
