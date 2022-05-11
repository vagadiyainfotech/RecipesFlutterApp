
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:indianfastfoodrecipes/app/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await setUpMessaging();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // await Firebase.initializeApp();
  NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const IndianFastFoodRecipes());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

Future<void> setUpMessaging() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  String? token = await messaging.getToken(
    vapidKey: "BNhEEKzPrpoiYI7_xRUyYdBmsLnqtgE__US4gCs_u8C62CzYzTVjdm_mrbS4Fenp_ose21Ho_MWFU2Lo90pmbec",
  );
  print('tokentokentokentokentokentokentokentokentokentoken----${token}');
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'channelName'
    'High Importance Notifications', // title
    description: 'your channel description',
    importance: Importance.max,

  );
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('notification');

  final MacOSInitializationSettings initializationSettingsMacOS = const MacOSInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      macOS: initializationSettingsMacOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
   /* const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('high_importance_channel', 'channelName',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }*/
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android?.smallIcon,color: Colors.white,priority: Priority.high,
              // other properties...
            ),
          ));
    }
  });

}
