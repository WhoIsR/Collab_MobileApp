import 'package:flutter/material.dart';

class TeamMember {
  final String name;
  final String nim;
  final String photoUrl;
  final String className;
  final String skills;

  TeamMember({
    required this.name,
    required this.nim,
    required this.photoUrl,
    required this.className,
    required this.skills,
  });
}

class ProfileTeamPage extends StatelessWidget {
  const ProfileTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
