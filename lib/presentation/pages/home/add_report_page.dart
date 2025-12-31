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

class _FormHeader extends StatelessWidget {
  const _FormHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Icon(Icons.pets, size: 60, color: AppColors.primary),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Laporkan Hewan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textOutline,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Bantu selamatkan hewan di sekitarmu',
            style: TextStyle(
              color: AppColors.textOutline.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  _CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textOutline),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textOutline),
      ),
    );
  }
}

class _PickerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.textOutline, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textOutline),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textOutline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerArea extends StatelessWidget {
  final Uint8List? imageBytes;
  final VoidCallback onPickGallery;
  final VoidCallback onPickCamera;
  final VoidCallback onRemove;

  const _ImagePickerArea({
    required this.imageBytes,
    required this.onPickGallery,
    required this.onPickCamera,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textOutline, width: 2),
      ),
      child: imageBytes != null
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.memory(
                    imageBytes!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_photo_alternate,
                  size: 50,
                  color: AppColors.textOutline,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tambahkan Foto Hewan',
                  style: TextStyle(
                    color: AppColors.textOutline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _PickerButton(
                      icon: Icons.photo_library,
                      label: 'Galeri',
                      onTap: onPickGallery,
                    ),
                    const SizedBox(width: 16),
                    _PickerButton(
                      icon: Icons.camera_alt,
                      label: 'Kamera',
                      onTap: onPickCamera,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
