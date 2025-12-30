import 'package:flutter/material.dart';

class ProfileYasmin extends StatelessWidget {
  ProfileYasmin({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //nih gue buat stack buat header biar cakep
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, accentColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -50,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(myImagePath),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            //ini gua buat nama
            Text(
              myName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3436),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
