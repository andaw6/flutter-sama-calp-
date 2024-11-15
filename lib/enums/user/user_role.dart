import 'package:hive_flutter/hive_flutter.dart';

part 'user_role.g.dart';

@HiveType(typeId: 4)
enum UserRole {
  @HiveField(0)
  admin,

  @HiveField(1)
  agent,

  @HiveField(2)
  client,

  @HiveField(3)
  vendor
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.admin:
        return 'ADMIN';
      case UserRole.agent:
        return 'AGENT';
      case UserRole.client:
        return 'CLIENT';
      case UserRole.vendor:
        return 'VENDOR';
    }
  }

  static UserRole fromString(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return UserRole.admin;
      case 'AGENT':
        return UserRole.agent;
      case 'CLIENT':
        return UserRole.client;
      case 'VENDOR':
        return UserRole.vendor;
      default:
        throw ArgumentError('Invalid UserRole value: $role');
    }
  }
}
