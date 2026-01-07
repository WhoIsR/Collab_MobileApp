import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
        'high_importance_channel_new',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Request Permission buat Android 13+ (kata gemini wajib)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      debugPrint('User declined or has not accepted permission');
      return;
    }
    debugPrint('User granted permission');

    // 2. Setup Local Notifications (Android)
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("User tapped on local notification: ${response.payload}");
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // notification saat aplikasi dibuka
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        "FCM Message Received (Foreground): ${message.notification?.title}",
      );

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // Tampilkan notifikasi lokal biar muncul pop-up
      if (notification != null && android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher',
              priority: Priority
                  .max, // menggunakan Priority.max biar muncul terus cuy notifnya
              importance: Importance.max,
              ticker: 'New Notification',
              playSound: true,
              enableVibration: true,
              visibility: NotificationVisibility.public,
            ),
          ),
          payload: message.data.toString(),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        "FCM Message Clicked (Background/Terminated): ${message.messageId}",
      );
    });

    // buat debug
    String? token = await _fcm.getToken();
    debugPrint("==================================================");
    debugPrint("FCM TOKEN: $token");
    debugPrint("==================================================");

    _isInitialized = true;
  }

  // FUNGSI SIMPEL: Tampilkan notifikasi langsung dari kode (Tanpa Internet)
  Future<void> showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel_new',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.max,
          ticker: 'New Notification',
          playSound: true,
          enableVibration: true,
          visibility: NotificationVisibility.public,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      details,
    );
  }
}
