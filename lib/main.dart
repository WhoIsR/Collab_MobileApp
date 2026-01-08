import 'package:collab_mobile_app/presentation/pages/splashscreen/splash_farhan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:collab_mobile_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collab_mobile_app/data/services/notification_service.dart';
import 'package:collab_mobile_app/core/theme/app_theme.dart';

Future<void> _initApp() async {
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

  // Inisialisasi Notifikasi (FCM)
  try {
    await NotificationService().initialize();
    debugPrint('✓ Notification service initialized');
  } catch (e) {
    debugPrint('Notification init error: $e');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Simpan future di variabel state agar tidak dipanggil ulang saat rebuild
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawsRes',
      theme: AppTheme.cartoonTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          // Jika inisialisasi selesai, tampilkan Splash Screen (Splash1Page)
          if (snapshot.connectionState == ConnectionState.done) {
            return const Splash1Page();
          }

          // Selama masih loading, tampilkan indikator loading
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
