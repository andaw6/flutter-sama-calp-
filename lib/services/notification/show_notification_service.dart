import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/notification/notification.dart' as app;
import 'package:wave_odc/services/notification/notification_service.dart';

class ShowNotificationService{
  static final _notificationService = locator<NotificationService>();
  static int _id = 0;
  static void show ({
    required app.Notification notification,
    int id = 0,
  }) async {
    id = id > 0 ? id : ++_id;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: "basic_channel",
        title: "Sama Calpé",
        body: notification.message,
      ),
    );
    _notificationService.markRead(id: notification.id);
  }

  static void shows({List<app.Notification> notifications = const []}){
    for(var notification in notifications){
      show(notification: notification);
    }
  }

}