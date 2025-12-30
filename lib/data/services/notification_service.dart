import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Inisialisasi Notifikasi
  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint('FCM: Skipping notification setup for Web');
      return;
    }

    try {
      // 1. Request Permission (Wajib buat Android 13+)
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }

      // 2. Mendapatkan Token (Buat test kirim dari Firebase Console)
      String? token = await _fcm.getToken();
      debugPrint("==================================================");
      debugPrint("FCM Device Token: $token");
      debugPrint("==================================================");

      // 3. Listener saat aplikasi sedang dibuka (Foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint(
            'Message also contained a notification: ${message.notification}',
          );
        }
      });
    } catch (e) {
      debugPrint('Error initializing FCM: $e');
    }
  }
}
