import 'dart:async';
import 'package:collab_mobile_app/presentation/pages/splashscreen/splash_yasmin.dart';
import 'package:flutter/material.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';

class Splash1Page extends StatefulWidget {
  const Splash1Page({super.key});

  @override
  State<Splash1Page> createState() => _Splash1PageState();
}

class _Splash1PageState extends State<Splash1Page> {
  @override
  void initState() {
    super.initState();
    // Tampil 4 detik
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashYasmin()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan Logo Kampus
            Image.asset(
              'assets/images/splash2.png',
              width: 200,
              height: 200,
              errorBuilder: (ctx, err, stack) => const Icon(
                Icons.school,
                size: 100,
                color: AppColors.textOutline,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Global Institute',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textOutline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
