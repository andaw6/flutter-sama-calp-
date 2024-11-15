import 'package:uuid/uuid.dart';
import 'package:wave_odc/enums/notification/notification_status.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'notification.g.dart';


@HiveType(typeId: 10)
class Notification {

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String message;

  @HiveField(3)
  NotificationStatus status;
  
  @HiveField(4)
  DateTime createdAt;
  
  @HiveField(5)
  DateTime? readAt;


  Notification({
    required this.id,
    required this.userId,
    required this.message,
    required this.status,
    required this.createdAt,
    this.readAt
  });


    // Générer un UUID pour chaque nouvel objet Bill
  factory Notification.create(String userId, String message,
      NotificationStatus status) {
    return Notification(
        id: const Uuid().v4(),
        userId: userId,
        message: message,
        status: status,
        createdAt: DateTime.now()
    );
  }

  // Méthode fromJson pour la désérialisation d'un JSON
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['userId'],
      message: json['message'],
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']).toUtc() : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']).toUtc() : DateTime.now(),
      status: NotificatioStatusExtension.fromString(json['isRead']),
    );
  }
}

