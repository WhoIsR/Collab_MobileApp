import 'package:collab_mobile_app/presentation/pages/auth/login.dart';
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
  bool _isLoading = false;

  void _handleGetStarted() async {
    setState(() => _isLoading = true);

    // Simulasi loading biar keren aje
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    // Cek status login Firebase
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: _SplashCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _AnimatedIcon(),
                const SizedBox(height: 24),
                const _SplashTexts(),
                const SizedBox(height: 32),
                _StartButton(
                  isLoading: _isLoading,
                  onPressed: _handleGetStarted,
                ),
              ],
            ),
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

class _StartButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _StartButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOutline,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: AppColors.textOutline, width: 3),
          ),
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textOutline,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Memuat..."),
                ],
              )
            : const Text(
                "MULAI SEKARANG",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
      ),
    );
  }
}

class _SplashCard extends StatelessWidget {
  final Widget child;

  const _SplashCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.textOutline, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
