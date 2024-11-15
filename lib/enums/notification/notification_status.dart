import 'package:hive_flutter/hive_flutter.dart';


part 'notification_status.g.dart';


@HiveType(typeId: 1)
enum NotificationStatus {
  @HiveField(0)
  unread,

  @HiveField(1)
  read,
}

extension NotificatioStatusExtension on NotificationStatus {
  String get name {
    switch (this) {
      case NotificationStatus.unread:
        return 'UNREAD';
      case NotificationStatus.read:
        return 'READ';
    }
  }

  static NotificationStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'UNREAD':
        return NotificationStatus.unread;
      case 'READ':
        return NotificationStatus.read;
      default:
        throw ArgumentError('Invalid NotifactionStatus value: $status');
    }
  }
}

