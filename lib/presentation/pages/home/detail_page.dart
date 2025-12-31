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
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final String imageUrl;

  const _HeaderImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(27)),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (ctx, error, stack) => Container(
            color: Colors.grey[200],
            child: const Icon(
              Icons.pets,
              size: 100,
              color: AppColors.textOutline,
            ),
          ),
        ),
      ),
    );
  }
}
