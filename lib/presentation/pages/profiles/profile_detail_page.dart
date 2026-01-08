import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'profile_team_page.dart';

class ProfileDetailPage extends StatelessWidget {
  final TeamMember member;

  const ProfileDetailPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(member.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.textOutline, width: 3),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(8, 8),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textOutline, width: 3),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(member.photoUrl),
                  backgroundColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              // Name
              Text(
                member.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOutline,
                ),
              ),
              const SizedBox(height: 8),

              // NIM
              Text(
                "NIM: ${member.nim}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textOutline.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              // Class
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.textOutline, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.class_,
                      size: 16,
                      color: AppColors.textOutline,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Kelas: ${member.className}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textOutline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Skills Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.textOutline, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Keahlian",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textOutline,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.code, "Skills", member.skills),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textOutline),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textOutline.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOutline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
