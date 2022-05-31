// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {


//   FirebaseOptions firebaseOptions = const FirebaseOptions(
//     appId: '1:1077568560408:android:0a86351c466de8a374d26d',
//     apiKey: 'AIzaSyB34ddpS8epSKheG-nUGC1mP_aPmWRPQoU',
//     projectId: 'tempo-app-8e5b9',
//     messagingSenderId: '448618578101',
//   );
//   await Firebase.initializeApp(options: firebaseOptions);
//   print('Handling a background message ${message.messageId}');
// }

// Future<void> initAppFirebase() async {
//   AndroidNotificationChannel channel;

//   /// Initialize the [FlutterLocalNotificationsPlugin] package.
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   WidgetsFlutterBinding.ensureInitialized();

//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   if (!kIsWeb) {
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       // 'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );

//     // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     /// Create an Android Notification Channel.

//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
// }
