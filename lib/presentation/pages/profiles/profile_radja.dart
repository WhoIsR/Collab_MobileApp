import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLinkedinHovered = false;
  bool _isInstagramHovered = false;
  bool _isGithubHovered = false;
  bool _isEmailHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF64B5F6).withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF64B5F6).withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/portoflutter.JPG',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white54,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Column(
                children: [
                  const Text(
                    'Radja Satrio Seftiano',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF64B5F6).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF64B5F6).withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Text(
                      'TEAM LEADER',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64B5F6),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF64B5F6,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.badge_outlined,
                            size: 20,
                            color: Color(0xFF64B5F6),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NIM',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              '1123150172',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(
                        color: Colors.white.withValues(alpha: 0.1),
                        thickness: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF64B5F6,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.school_outlined,
                            size: 20,
                            color: Color(0xFF64B5F6),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kelas',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              'TI SE P-2',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SKILLS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          [
                            'Flutter Basic',
                            'Firebase',
                            'UI/UX',
                            'Supabase',
                            'Dart',
                            'Git',
                          ].map((skill) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                              child: Text(
                                skill,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ROLE DESCRIPTION',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Leading the team with focus on coordination and development. Responsible for task distribution, timeline management, and core Flutter implementation.',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => _isLinkedinHovered = true),
                    onExit: (_) => setState(() => _isLinkedinHovered = false),
                    child: GestureDetector(
                      onTap: () => _launchUrl(
                        'https://www.linkedin.com/in/radja-satrio-seftiano',
                      ),
                      onTapDown: (_) =>
                          setState(() => _isLinkedinHovered = true),
                      onTapUp: (_) =>
                          setState(() => _isLinkedinHovered = false),
                      onTapCancel: () =>
                          setState(() => _isLinkedinHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isLinkedinHovered
                              ? const Color(0xFF64B5F6).withValues(alpha: 0.2)
                              : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _isLinkedinHovered
                                ? const Color(0xFF64B5F6)
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _isLinkedinHovered
                                  ? const Color(
                                      0xFF64B5F6,
                                    ).withValues(alpha: 0.2)
                                  : Colors.black.withValues(alpha: 0.2),
                              blurRadius: _isLinkedinHovered ? 15 : 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        transform: _isLinkedinHovered
                            ? Matrix4.translationValues(0, -4, 0)
                            : Matrix4.identity(),
                        child: Icon(
                          Icons.link,
                          color: _isLinkedinHovered
                              ? const Color(0xFF64B5F6)
                              : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  MouseRegion(
                    onEnter: (_) => setState(() => _isInstagramHovered = true),
                    onExit: (_) => setState(() => _isInstagramHovered = false),
                    child: GestureDetector(
                      onTap: () =>
                          _launchUrl('https://www.instagram.com/satrioradja'),
                      onTapDown: (_) =>
                          setState(() => _isInstagramHovered = true),
                      onTapUp: (_) =>
                          setState(() => _isInstagramHovered = false),
                      onTapCancel: () =>
                          setState(() => _isInstagramHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isInstagramHovered
                              ? const Color(0xFF64B5F6).withValues(alpha: 0.2)
                              : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _isInstagramHovered
                                ? const Color(0xFF64B5F6)
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _isInstagramHovered
                                  ? const Color(
                                      0xFF64B5F6,
                                    ).withValues(alpha: 0.2)
                                  : Colors.black.withValues(alpha: 0.2),
                              blurRadius: _isInstagramHovered ? 15 : 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        transform: _isInstagramHovered
                            ? Matrix4.translationValues(0, -4, 0)
                            : Matrix4.identity(),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: _isInstagramHovered
                              ? const Color(0xFF64B5F6)
                              : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  MouseRegion(
                    onEnter: (_) => setState(() => _isGithubHovered = true),
                    onExit: (_) => setState(() => _isGithubHovered = false),
                    child: GestureDetector(
                      onTap: () => _launchUrl('https://github.com/WhoIsR'),
                      onTapDown: (_) => setState(() => _isGithubHovered = true),
                      onTapUp: (_) => setState(() => _isGithubHovered = false),
                      onTapCancel: () =>
                          setState(() => _isGithubHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isGithubHovered
                              ? const Color(0xFF64B5F6).withValues(alpha: 0.2)
                              : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _isGithubHovered
                                ? const Color(0xFF64B5F6)
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _isGithubHovered
                                  ? const Color(
                                      0xFF64B5F6,
                                    ).withValues(alpha: 0.2)
                                  : Colors.black.withValues(alpha: 0.2),
                              blurRadius: _isGithubHovered ? 15 : 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        transform: _isGithubHovered
                            ? Matrix4.translationValues(0, -4, 0)
                            : Matrix4.identity(),
                        child: Icon(
                          Icons.code,
                          color: _isGithubHovered
                              ? const Color(0xFF64B5F6)
                              : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  MouseRegion(
                    onEnter: (_) => setState(() => _isEmailHovered = true),
                    onExit: (_) => setState(() => _isEmailHovered = false),
                    child: GestureDetector(
                      onTap: () => _launchUrl('mailto:radjasatrio70@gmail.com'),
                      onTapDown: (_) => setState(() => _isEmailHovered = true),
                      onTapUp: (_) => setState(() => _isEmailHovered = false),
                      onTapCancel: () =>
                          setState(() => _isEmailHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isEmailHovered
                              ? const Color(0xFF64B5F6).withValues(alpha: 0.2)
                              : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _isEmailHovered
                                ? const Color(0xFF64B5F6)
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _isEmailHovered
                                  ? const Color(
                                      0xFF64B5F6,
                                    ).withValues(alpha: 0.2)
                                  : Colors.black.withValues(alpha: 0.2),
                              blurRadius: _isEmailHovered ? 15 : 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        transform: _isEmailHovered
                            ? Matrix4.translationValues(0, -4, 0)
                            : Matrix4.identity(),
                        child: Icon(
                          Icons.email_outlined,
                          color: _isEmailHovered
                              ? const Color(0xFF64B5F6)
                              : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
