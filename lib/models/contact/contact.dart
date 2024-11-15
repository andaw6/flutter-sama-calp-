import 'package:uuid/uuid.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'contact.g.dart';

@HiveType(typeId: 8)
class Contact {

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String? email;
  
  @HiveField(5)
  bool favorite;

  @HiveField(6)
  UserInfo? user;

  Contact({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.favorite = false,
    this.user,
  });

  // Générer un UUID pour chaque nouveau contact
  factory Contact.create(String userId, String name, String phoneNumber,
      [String? email]) {
    DateTime now = DateTime.now();
    return Contact(
      id: const Uuid().v4(), // Génération d'un UUID
      userId: userId,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      favorite: false,
    );
  }

  // Méthode fromJson pour la désérialisation d'un JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      favorite: json['favorite'] ?? false,
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null, // Si 'user' est présent dans le JSON, crée un objet User
    );
  }
}
