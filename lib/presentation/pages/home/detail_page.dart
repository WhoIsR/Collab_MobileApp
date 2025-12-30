import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';

class DetailPage extends StatelessWidget {
  final AnimalReport report;

  const DetailPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(title: const Text('Detail Laporan')),
      body: const Center(
        child: CircularProgressIndicator(),
      ), // Placeholder dulu
    );
  }
}
