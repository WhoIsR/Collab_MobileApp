import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FcmV1Service {
  static Future<String?> sendNotificationToAll(String judul, String isi) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/service_account.json',
      );
      final Map<String, dynamic> serviceAccount = json.decode(jsonString);

      if (serviceAccount['private_key'] is String) {
        serviceAccount['private_key'] =
            (serviceAccount['private_key'] as String).replaceAll(r'\n', '\n');
      }

      final String projectId = serviceAccount['project_id'];

      final accountCredentials = ServiceAccountCredentials.fromJson(
        serviceAccount,
      );
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = await clientViaServiceAccount(accountCredentials, scopes);
      final String token = client.credentials.accessToken.data;

      final Map<String, dynamic> body = {
        "message": {
          "topic": "all_users",
          "notification": {"title": judul, "body": isi},
          "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"},
        },
      };

      final response = await http.post(
        Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      client.close();

      if (response.statusCode == 200) {
        return null; // Sukses!
      } else {
        return "Gagal Server: ${response.statusCode} ${response.body}";
      }
    } catch (e) {
      // Tambahkan Jam Device biar ketahuan kalau jamnya ngaco
      final jamDevice = DateTime.now();
      return "Error: $e | Jam Device: $jamDevice";
    }
  }
}
