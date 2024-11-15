// lib/models/company.dart

import 'package:uuid/uuid.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'company.g.dart';

@HiveType(typeId: 7)
class Company {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String type;

  @HiveField(4)
  String? icon; // Nullable

  Company({
    required this.id,
    required this.name,
    required this.type,
    this.icon,
  });

  // Générer un UUID pour chaque nouvelle entreprise
  factory Company.create(String name, String type, [String? icon]) {
    return Company(
      id: const Uuid().v4(), // Génération d'un UUID
      name: name,
      type: type,
      icon: icon,
    );
  }

  // Méthode fromJson pour la désérialisation d'un JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      icon: json['icon'], // Si l'icône est présente, elle sera affectée, sinon elle sera null
    );
  }
}
