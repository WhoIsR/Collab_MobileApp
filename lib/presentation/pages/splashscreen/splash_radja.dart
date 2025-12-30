import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collab_mobile_app/presentation/pages/home/dashboard_page.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';

class Splash3Page extends StatefulWidget {
  const Splash3Page({super.key});

  @override
  State<Splash3Page> createState() => _Splash3PageState();
}

class _Splash3PageState extends State<Splash3Page> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("ngetest lagi aje ", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedIcon extends StatelessWidget {
  const _AnimatedIcon();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: const Icon(
            Icons.volunteer_activism,
            size: 80,
            color: AppColors.primary,
          ),
        );
      },
    );
  }
}

class _SplashTexts extends StatelessWidget {
  const _SplashTexts();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1200),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Column(
            children: [
              const Text(
                "Peduli Hewan,\nPeduli Kehidupan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOutline,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Bersama membangun komunitas yang lebih baik untuk sahabat berbulu kita.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textOutline.withOpacity(0.7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
