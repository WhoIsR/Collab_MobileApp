import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  final String _bucketName = 'pawsres_assets';

  Future<String?> uploadImage(Uint8List bytes, String fileName) async {
    try {
      final String uniqueFileName =
          '${DateTime.now().millisecondsSinceEpoch}_$fileName';

      debugPrint('📤 Uploading image: $uniqueFileName');

      // Upload ke Supabase Storage
      await _supabase.storage
          .from(_bucketName)
          .uploadBinary(
            uniqueFileName,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );

      // Ambil URL publik
      final String publicUrl = _supabase.storage
          .from(_bucketName)
          .getPublicUrl(uniqueFileName);

      debugPrint('✓ Upload berhasil: $publicUrl');
      return publicUrl;
    } catch (e) {
      debugPrint('✗ Error upload gambar: $e');
      debugPrint(
        'Pastikan bucket "$_bucketName" sudah dibuat di Supabase Storage!',
      );
      return null;
    }
  }

  // Hapus gambar dari Storage
  Future<bool> deleteImage(String fileName) async {
    try {
      await _supabase.storage.from(_bucketName).remove([fileName]);
      return true;
    } catch (e) {
      debugPrint('✗ Error hapus gambar: $e');
      return false;
    }
  }
}
