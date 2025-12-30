import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get cartoonTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor:
          AppColors.secondary, // Background halaman biru (#6EB9F7)
      // Font "Fredoka"
      fontFamily: GoogleFonts.fredoka().fontFamily,
      textTheme: GoogleFonts.fredokaTextTheme().apply(
        bodyColor: AppColors.textOutline,
        displayColor: AppColors.textOutline,
      ),

      // Skema Warna
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        onSurface: AppColors.textOutline,
        outline: AppColors.textOutline,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textOutline,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.fredoka(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textOutline,
        ),
        iconTheme: const IconThemeData(color: AppColors.textOutline, size: 28),
      ),

      // Elevated Button (Tombol Kartun)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOutline,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: AppColors.textOutline,
              width: 3,
            ), // Outline tebal
          ),
          textStyle: GoogleFonts.fredoka(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOutline,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.textOutline, width: 3),
        ),
      ),

      // Card Theme (Standard fallback)
      cardTheme: CardThemeData(
        color: AppColors.surface, // Putih Salju
        elevation:
            0, // Matikan shadow default biar kita bisa custom hard shadow kalau mau
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Radius gede 25px
          side: const BorderSide(
            color: AppColors.textOutline,
            width: 3,
          ), // Outline 3px
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.textOutline, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.textOutline, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.textOutline, width: 4),
        ),
        labelStyle: const TextStyle(
          color: AppColors.textOutline,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          color: AppColors.textOutline.withValues(alpha: 0.5),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.textOutline,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
