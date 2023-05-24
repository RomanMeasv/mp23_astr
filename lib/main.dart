import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mp23_astr/app/modules/user_module/binding.dart';
import 'package:mp23_astr/app/modules/user_module/page.dart';
import 'package:get/get.dart';

import 'app/routes/pages.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await _initializeFirebase();

  // Run with emulators
  await _runWithEmulators(true);

  // Setup Firebase Messaging
  await _setupFirebaseMessaging();

  runApp(const Mp23Astr());
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

const firestoreEmulatorPort = 8080;
const storageEmulatorPort = 9199;
const authEmulatorPort = 9099;

Future<void> _runWithEmulators(bool emulators) async {
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', firestoreEmulatorPort);
  await FirebaseStorage.instance.useStorageEmulator('localhost', storageEmulatorPort);
  await FirebaseAuth.instance.useAuthEmulator('localhost', authEmulatorPort);
}

Future<void> _setupFirebaseMessaging() async {
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

  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print('User has denied notification permissions.');
  } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission: ${settings.authorizationStatus}');
    await _setupNotifications(messaging);
  }
}

class Mp23Astr extends StatelessWidget {
  const Mp23Astr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      initialBinding: UserBinding(),
      getPages: AppPages.pages,
      home: UserPage(),
    );
  }
}

Future<void> _setupNotifications(FirebaseMessaging messaging) async {
  //Foreground
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //Background
  FirebaseMessaging.onBackgroundMessage(_handleIncomingMessageInBackground);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _handleIncomingMessage(message, flutterLocalNotificationsPlugin);
  });
}

void _handleIncomingMessage(RemoteMessage message, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
    var notification = message.notification!;

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            icon: 'app_icon',
          ),
        )
    );
  }
}

Future<void> _handleIncomingMessageInBackground(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}