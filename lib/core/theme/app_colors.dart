import 'package:flutter/material.dart';

class AppColors {
  // --primary-color: #FFD93D (Kuning - Tombol)
  static const Color primary = Color(0xFFFFD93D);

  // --secondary-color: #6EB9F7 (Biru Langit - Background Halaman)
  static const Color secondary = Color(0xFF6EB9F7);
  static const Color background =
      secondary; // Alias untuk backward compatibility

  // --bg-color: #FDFFFC (Putih Salju - Background Kartu)
  static const Color surface = Color(0xFFFDFFFC);

  // --text-color: #4A4E69 (Abu Gelap - Garis & Teks)
  static const Color textOutline = Color(0xFF4A4E69);

  // Variasi
  static const Color white = Colors.white;
  static const Color error = Colors.redAccent;
}
