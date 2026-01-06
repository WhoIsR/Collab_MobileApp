import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';

class DetailPage extends StatelessWidget {
  final AnimalReport report;

  const DetailPage({super.key, required this.report});

  Future<void> _launchWhatsApp() async {
    final String phone = report.contactWa;
    final String message =
        "Halo, saya ingin bertanya tentang laporan hewan '${report.apiName}'...";

    final Uri url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch WhatsApp');
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(title: const Text('Detail Laporan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderImage(imageUrl: report.imageUrl),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleSection(
                      name: report.apiName,
                      location: report.location,
                    ),
                    _DescriptionSection(description: report.description),
                    const SizedBox(height: 40),
                    _ContactButton(onPressed: _launchWhatsApp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

class _ContactButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ContactButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.message, color: Colors.white),
        label: const Text(
          'Hubungi via WhatsApp',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25D366),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: AppColors.textOutline, width: 3),
          ),
        ),
      ),
    );
  }
}
