import 'package:flutter/material.dart';

// BAGIAN SI RADJA

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        // actions: [
        //   IconButton(
        //     onPressed: () => AuthService().logout(), // Tombol logout
        //     icon: const Icon(Icons.logout),
        //   ),
        // ],
      ),
      body: const Center(child: Text("Ini Dashboard Utama")),
    );
  }
}
