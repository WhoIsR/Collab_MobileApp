import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Kelas untuk konfigurasi tema aplikasi.
/// TODO: Implementasi tema lengkap sesuai kebutuhan design.
class AppTheme {
  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      // TODO: Tambahkan konfigurasi tema lainnya
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      // TODO: Tambahkan konfigurasi tema lainnya
    );
  }
}
