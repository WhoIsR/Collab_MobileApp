import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';
import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:collab_mobile_app/data/services/report_service.dart';
import 'package:collab_mobile_app/data/services/storage_service.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(title: const Text('scaffold baru lagi cuy')),
      body: const Center(child: CircularProgressIndicator()), // Placeholder
    );
  }
}
