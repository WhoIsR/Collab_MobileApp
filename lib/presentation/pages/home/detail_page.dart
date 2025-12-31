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

class _TitleSection extends StatelessWidget {
  final String name;
  final String location;

  const _TitleSection({required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textOutline,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.error),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final String description;

  const _DescriptionSection({required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 30, thickness: 2, color: AppColors.textOutline),
        const Text(
          "Deskripsi Kondisi:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textOutline,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: AppColors.textOutline.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
