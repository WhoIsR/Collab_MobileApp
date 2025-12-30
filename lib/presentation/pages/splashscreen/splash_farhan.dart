import 'package:flutter/material.dart';
import 'package:tgl_31/screen/profil.dart';


class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(height: 50),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF4F2F7),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('android/assets/images/image_1.jpg'),
                ),
              ),
            ),