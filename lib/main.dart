import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:collab_mobile_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collab_mobile_app/data/services/notification_service.dart';
import 'package:collab_mobile_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inisialisasi Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✓ Firebase initialized');
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawsRes',
      theme: AppTheme.cartoonTheme,
      home: , //Todo han panggil splash screen lu di sini
      debugShowCheckedModeBanner: false,
    );
  }
}
