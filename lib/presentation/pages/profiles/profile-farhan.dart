import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
       body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto Profil
            CircleAvatar(
              radius: 70,
              backgroundImage: const AssetImage('android/assets/images/image_2.jpg'),
              backgroundColor: Colors.deepPurple[100],
            ),