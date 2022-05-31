import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tempo/firebase_options.dart';

import 'preferences/shared_preferences.dart';

Future<void> firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await Firebase.initializeApp();
  await requestFbToken();
  try {
    FirebaseMessaging.onBackgroundMessage(_firebaseBGHandler);
    // AwesomeNotifications().initialize(null, // icon for your app notification
    //     [
    //       NotificationChannel(
    //           channelKey: 'key1',
    //           channelName: 'Proto Coders Point',
    //           channelDescription: "Notification example",
    //           defaultColor: const Color(0XFF9050DD),
    //           ledColor: Colors.white,
    //           playSound: true,
    //           enableLights: true,
    //           enableVibration: true)
    //     ]);
    // ignore: empty_catches
  } catch (ex) {}
}

Future<void> _firebaseBGHandler(RemoteMessage message) async {
  if (message.notification!.title!.isNotEmpty ||
      message.notification!.body!.isEmpty) {
    String? imageUrl;
    imageUrl ??= message.notification!.android!.imageUrl!;
    //   Map<String, dynamic> notificationAdapter = {
    //     NOTIFICATION_CHANNEL_KEY: 'basic_channel',
    //     NOTIFICATION_ID: message.data[NOTIFICATION_CONTENT][NOTIFICATION_ID] ??
    //         message.messageId ??
    //         Random().nextInt(2147483647),
    //     NOTIFICATION_TITLE: message.data[NOTIFICATION_CONTENT]
    //             [NOTIFICATION_TITLE] ??
    //         message.notification?.title,
    //     NOTIFICATION_BODY: message.data[NOTIFICATION_CONTENT]
    //             [NOTIFICATION_BODY] ??
    //         message.notification?.body,
    //     NOTIFICATION_LAYOUT:
    //        imageUrl.isEmpty ? 'Default' : 'BigPicture',
    //     NOTIFICATION_BIG_PICTURE: imageUrl
    //   };
    //   AwesomeNotifications()
    //       .createNotificationFromJsonData(notificationAdapter);
    // } else {
    //   AwesomeNotifications().createNotificationFromJsonData(message.data);
    // }
  }
}

Future<String?> requestFbToken() async {
  String? token = await AppData().getString("fcmToken");

  // print("Prio token is token is $token");
  if (token!.length<10) {
    try {
      FirebaseMessaging messaging;
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) async {
        token = value;
        print("Firebase token is $value");
        await AppData().storeValue("fcmToken", value);
      });
      // ignore: empty_catches
    } catch (ex) {
      print(ex);
    }
  }
  // ignore: empty_catches
  return token;
}

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     return true;
    //   }
    //   return false;
    // } on SocketException catch (_) {
    //   return false;
    // }
  }
  return false;
}
