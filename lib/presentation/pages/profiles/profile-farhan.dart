import 'package:flutter/material.dart';

class ProfileFarhan extends StatelessWidget {
  const ProfileFarhan({super.key});

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
              backgroundImage: const AssetImage(
                'android/images/assets/image_2.jpg',
              ),
              backgroundColor: Colors.deepPurple[100],
            ),

            const SizedBox(height: 20),

            // Nama
            const Text(
              'M.Farhan Nabawi',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            // Profesi / Status
            Text(
              'Mahasiswa Informatika',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),

            const SizedBox(height: 30),

            // Card Data Diri
            _buildProfileItem(
              icon: Icons.badge,
              title: 'NIM',
              value: '1123150170',
            ),
            _buildProfileItem(
              icon: Icons.person,
              title: 'Nama',
              value: 'Teknik Informatika',
            ),
            _buildProfileItem(
              icon: Icons.school,
              title: 'Jurusan',
              value: 'Teknik Informatika',
            ),
            _buildProfileItem(
              icon: Icons.class_,
              title: 'Kelas',
              value: 'TI SE 23',
            ),
          ],
        ),
      ),
    );
  }

  // Widget item data diri
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
