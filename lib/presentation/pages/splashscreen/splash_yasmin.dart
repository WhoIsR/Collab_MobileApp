import 'dart:async';

import 'package:flutter/material.dart';

class SplashYasmin extends StatefulWidget {
  const SplashYasmin({super.key});

  @override
  State<SplashYasmin> createState() => _SplashYasminState();
}

class _SplashYasminState extends State<SplashYasmin> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Splash3Page()),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
