import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';
import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:collab_mobile_app/data/services/report_service.dart';
import 'package:collab_mobile_app/data/services/storage_service.dart';
import 'package:collab_mobile_app/data/services/notification_service.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();

  final ReportService _reportService = ReportService();
  final StorageService _storageService = StorageService();
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false;
  Uint8List? _selectedImageBytes;
  String? _selectedImageName;

  @override
  void dispose() {
    _namaController.dispose();
    _lokasiController.dispose();
    _deskripsiController.dispose();
    _kontakController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
          _selectedImageName = pickedFile.name;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih gambar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _submitReport() async {
    if (_namaController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _kontakController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final String _namaHewan = _namaController.text.trim();

    String imageUrl =
        'https://images.unsplash.com/photo-1574158622682-e40e69881006';

    if (_selectedImageBytes != null && _selectedImageName != null) {
      final uploadedUrl = await _storageService.uploadImage(
        _selectedImageBytes!,
        _selectedImageName!,
      );
      if (uploadedUrl != null) imageUrl = uploadedUrl;
    }

    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    final report = AnimalReport(
      id: '',
      apiName: _namaController.text.trim(),
      location: _lokasiController.text.trim(),
      description: _deskripsiController.text.trim(),
      contactWa: _kontakController.text.trim(),
      imageUrl: imageUrl,
      userId: userId,
    );

    final success = await _reportService.addReport(report);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      await NotificationService().showLocalNotification(
        'Laporan Diterima! 🐾',
        'Terima kasih teman, $_namaHewan sudah masuk laporan nih!',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Laporan berhasil dikirim! ✓'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal mengirim laporan. Pastikan tabel Supabase aman!',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(title: const Text('Buat Laporan Baru')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
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
              const _FormHeader(),
              const SizedBox(height: 32),
              _ImagePickerArea(
                imageBytes: _selectedImageBytes,
                onPickGallery: () => _pickImage(ImageSource.gallery),
                onPickCamera: () => _pickImage(ImageSource.camera),
                onRemove: () => setState(() {
                  _selectedImageBytes = null;
                  _selectedImageName = null;
                }),
              ),
              const SizedBox(height: 24),
              _CustomTextField(
                controller: _namaController,
                label: 'Nama Hewan',
                hint: 'Contoh: Kucing Oren Terluka',
                icon: Icons.pets,
              ),
              const SizedBox(height: 16),
              _CustomTextField(
                controller: _lokasiController,
                label: 'Lokasi Ditemukan',
                hint: 'Contoh: Jl. Merdeka No. 10',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _CustomTextField(
                controller: _deskripsiController,
                label: 'Deskripsi Kondisi',
                hint: 'Jelaskan kondisi hewan...',
                icon: Icons.description,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              _CustomTextField(
                controller: _kontakController,
                label: 'Nomor WhatsApp',
                hint: '628xxxxxxxxxx',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              _SubmitButton(isLoading: _isLoading, onPressed: _submitReport),
            ],
          ),
        ),
      ),
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

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _SubmitButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.textOutline,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'KIRIM LAPORAN',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
