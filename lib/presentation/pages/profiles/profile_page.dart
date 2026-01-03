import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ReportService _reportService = ReportService();
  final User? _user = FirebaseAuth.instance.currentUser;

  int _totalReports = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  // Method publik untuk refresh dari luar
  void refresh() {
    _loadStats();
  }

  Future<void> _loadStats() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final userId = _user?.uid;
    if (userId != null) {
      final reports = await _reportService.getReportsByUser(userId);
      if (!mounted) return;
      setState(() {
        _totalReports = reports.length;
        _isLoading = false;
      });
    } else {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }



class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
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
                // Avatar with initial
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : "?",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOutline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nama
                Text(
                  displayName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textOutline,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textOutline.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
 // Join date
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
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.textOutline,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Bergabung: $joinDateStr",
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
                // Statistik
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.textOutline, width: 2),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.textOutline,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem("Laporan", _totalReports.toString()),
                            _buildVerticalDivider(),
                            _buildStatItem("Status", "Aktif"),
                            _buildVerticalDivider(),
                            _buildStatItem("Poin", "${_totalReports * 10}"),
                          ],
                        ),
                ),
                const SizedBox(height: 24),
                // Info Card
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
                        "Tentang Akun",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textOutline,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.email, "Email", email),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.verified_user,
                        "Status",
                        "Terverifikasi",
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.pets,
                        "Total Laporan",
                        "$_totalReports laporan",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 2,
      color: AppColors.textOutline.withValues(alpha: 0.3),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textOutline,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textOutline,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
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
                  color: AppColors.textOutline.withValues(alpha: 0.6),
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
              ]
  }
}
