import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart'; // Buat login ke Google
import 'package:http/http.dart' as http; // Buat kirim surat request

class FcmV1Service {
  // Fungsi Sakti: Kirim Notif ke SEMUA User (Topik 'all_users')
  static Future<void> sendNotificationToAll(String judul, String isi) async {
    try {
      // 1. BACA File Rahasia (Service Account)
      final String jsonString = await rootBundle.loadString(
        'assets/json/service_account.json',
      );
      final Map<String, dynamic> serviceAccount = json.decode(jsonString);

      // Ambil Project ID dari file itu
      final String projectId = serviceAccount['project_id'];

      // 2. MINTA IZIN ke Google (Dapet Token Akses)
      final accountCredentials = ServiceAccountCredentials.fromJson(
        serviceAccount,
      );
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = await clientViaServiceAccount(accountCredentials, scopes);
      final String token = client.credentials.accessToken.data; // Token sakti

      // 3. SIAPKAN PESAN (Format V1)
      final Map<String, dynamic> body = {
        "message": {
          "topic": "all_users", // Kirim ke grup 'all_users'
          "notification": {"title": judul, "body": isi},
          "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"},
        },
      };

      // 4. TEMBAK KE SERVER GOOGLE
      final response = await http.post(
        Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Pakai token sakti tadi
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print("✅ SUKSES! Notifikasi dikirim ke semua user.");
      } else {
        print("❌ GAGAL: ${response.body}");
      }

      // Jangan lupa tutup koneksi
      client.close();
    } catch (e) {
      print("❌ ERROR PARAH: $e");
    }
  }
}
