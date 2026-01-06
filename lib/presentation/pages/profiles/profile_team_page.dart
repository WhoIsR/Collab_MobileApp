import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'profile-farhan.dart';
import 'profile-yasmin.dart';
import 'profile_detail_page.dart';
import 'profile_radja.dart';

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
    final List<TeamMember> teamMembers = [
      TeamMember(
        name: "Radja Satrio Seftiano",
        nim: "1123150172",
        photoUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=WhoIsR",
        className: "06TPLM001",
        skills: "Mobile Development (Flutter), UI Design",
      ),
      TeamMember(
        name: "Aulia Yasmin Maharani",
        nim: "1123150146",
        photoUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Yasmin",
        className: "06TPLM001",
        skills: "System Analysis, Database Design",
      ),
      TeamMember(
        name: "Farhan Nabawi",
        nim: "1123150155",
        photoUrl: "https://api.dicebear.com/7.x/avataaars/png?seed=Nabawi",
        className: "06TPLM001",
        skills: "Backend Development, API Integration",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.secondary, // Blue Background
      appBar: AppBar(
        title: const Text('Tim Pengembang'),
        // Theme handled
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: teamMembers.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final member = teamMembers[index];
          return _buildMemberCard(context, member);
        },
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, TeamMember member) {
    return TeamMemberCard(member: member);
  }
}

class TeamMemberCard extends StatefulWidget {
  final TeamMember member;

  const TeamMemberCard({super.key, required this.member});

  @override
  State<TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<TeamMemberCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.member.name == "Radja Satrio Seftiano") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (widget.member.name == "Aulia Yasmin Maharani") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileYasmin()),
            );
          } else if (widget.member.name == "Farhan Nabawi") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileFarhan()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDetailPage(member: widget.member),
              ),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? (Matrix4.identity()..scale(1.02))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.surface, // White Card
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.textOutline, width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0x26000000),
                offset: _isHovered ? const Offset(8, 8) : const Offset(6, 6),
                blurRadius: _isHovered ? 10 : 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Avatar with Border
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textOutline, width: 2),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(widget.member.photoUrl),
                  backgroundColor: AppColors.background,
                  onBackgroundImageError: (exception, stackTrace) =>
                      const Icon(Icons.person, color: AppColors.textOutline),
                ),
              ),
              const SizedBox(width: 16),
              // Nama & Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.member.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textOutline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary, // Yellow Highlight tag
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.textOutline,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        widget.member.nim,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textOutline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Icon Panah
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: AppColors.textOutline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
