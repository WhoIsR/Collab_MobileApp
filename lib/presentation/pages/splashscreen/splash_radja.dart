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
