import 'dart:async';

import 'package:collab_mobile_app/core/theme/app_colors.dart';
import 'package:collab_mobile_app/presentation/pages/splashscreen/splash_radja.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashYasmin extends StatefulWidget {
  const SplashYasmin({super.key});

  @override
  State<SplashYasmin> createState() => _SplashYasminState();
}

class _SplashYasminState extends State<SplashYasmin> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Splash3Page()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Clean White
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan Animasi Lottie simple (network)
            Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_syqnfe7c.json', // Contoh animasi kucing lucu
              width: 250,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.pets,
                  size: 100,
                  color: AppColors.textOutline,
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading PawsRes...',
              style: TextStyle(fontSize: 18, color: AppColors.textOutline),
            ),
          ],
        ),
      ),
    );
  }
}
