import 'package:awesome_notifications/awesome_notifications.dart';

void notificationConfig(){
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "basic_channel",
        channelName: "Basic Notifications",
        channelDescription: "Notification channel for basic sama calpé"
    ),
  ],
      debug:true
  );
}