import 'package:flutter/material.dart';

class ProfileYasmin extends StatelessWidget {
  ProfileYasmin({super.key});

  //data diri
  final String myName = "Aulia Yasmin Maharani";
  final String myRole = "Mobile Application Developer";
  final String myNim = "1123150146";
  final String myDescription =
      "Mahasiswa IT yang berfokus pada pengembangan aplikasi mobile menggunakan Flutter. "
      "Memiliki ketertarikan mendalam pada UI/UX Design dan Backend Integration. "
      "Saat ini sedang mengembangkan aplikasi manajemen stok dan sistem POS.";
  final String myImagePath = 'images/assets/profile.jpeg';
  final List<String> mySkills = [
    "Flutter & Dart",
    "UI/UX Design",
    "Firebase / Supabase",
    "REST API",
    "Git & GitHub",
    "Agile Methodology",
  ];
  //palet warna
  final Color primaryColor = const Color(0xFFD81B60); // Pink tua elegan
  final Color accentColor = const Color(0xFFF48FB1); // Pink pastel
  final Color bgColor = const Color(0xFFF5F5F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
