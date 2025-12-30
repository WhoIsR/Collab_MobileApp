import 'package:flutter/material.dart';

class SplashYasmin extends StatefulWidget {
  const SplashYasmin({super.key});

  @override
  State<SplashYasmin> createState() => _SplashYasminState();
}

class _SplashYasminState extends State<SplashYasmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: const []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: []),
      ),
    );
  }
}
