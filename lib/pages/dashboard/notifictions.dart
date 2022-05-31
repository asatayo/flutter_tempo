import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebase() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    if (!event.notification!.body!.contains('ReferenceCode')) {
      // AwesomeNotifications().createNotification(
      //   content: NotificationContent(
      //     id: 11212,
      //     channelKey: 'key1',
      //     title: event.notification.title,
      //     body: event.notification.body,
      //   ),
      // );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    // setState(() {
    //   // notificationCounter = notificationCounter + 1;
    // });
  });
}
