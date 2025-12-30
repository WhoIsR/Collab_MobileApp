import 'dart:async';
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
    // Tampil 2 detik
    Timer(const Duration(seconds: 2), () {
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