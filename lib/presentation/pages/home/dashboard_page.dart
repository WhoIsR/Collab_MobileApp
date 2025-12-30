import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';
import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:collab_mobile_app/data/services/auth_service.dart';
import 'package:collab_mobile_app/data/services/report_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('PawsRes'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: const Center(child: Text("ngetest ae inimah")),
    );
  }
}
