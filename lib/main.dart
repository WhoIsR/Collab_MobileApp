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

  try {
    // Inisialisasi Supabase
    await Supabase.initialize(
      url: 'https://cevatssdgkkbwdgmmjsa.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNldmF0c3NkZ2trYndkZ21tanNhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzODk0NzMsImV4cCI6MjA4MDk2NTQ3M30.OhjhhoiAINtTQV1TxCckzUaTNWVJIFQEAq3mJ_EQLXM',
    );
    debugPrint('✓ Supabase initialized');
  } catch (e) {
    debugPrint('Supabase init error: $e');
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
