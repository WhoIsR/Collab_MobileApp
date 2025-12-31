import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_test/core/theme/app_colors.dart';
import 'package:uas_test/data/models/animal_report_model.dart';
import 'package:uas_test/data/services/report_service.dart';
import 'package:uas_test/presentation/pages/home/detail_page.dart';

class MyActivityPage extends StatefulWidget {
  const MyActivityPage({super.key});

  @override
  State<MyActivityPage> createState() => MyActivityPageState();
}

// Public state agar bisa dipanggil dari luar
class MyActivityPageState extends State<MyActivityPage> {
  final ReportService _reportService = ReportService();
  List<AnimalReport> _myReports = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMyReports();
  }

  // Method publik untuk refresh dari luar
  void refresh() {
    _loadMyReports();
  }

   Future<void> _loadMyReports() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final reports = await _reportService.getReportsByUser(userId);
      if (!mounted) return;
      setState(() {
        _myReports = reports;
        _isLoading = false;
      });
    } else {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

   Future<void> _deleteReport(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hapus Laporan?"),
        content: const Text("Laporan akan dihapus permanen."),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.textOutline, width: 3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _reportService.deleteReport(id);
      if (!mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Laporan berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
        _loadMyReports();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menghapus laporan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
            : _myReports.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: _loadMyReports,
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _myReports.length,
                itemBuilder: (context, index) =>
                    _buildActivityCard(_myReports[index]),
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history, size: 60, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text(
            'Belum ada aktivitas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textOutline,
            ),
          ),
            const SizedBox(height: 8),
          Text(
            'Laporan yang kamu buat akan muncul di sini',
            style: TextStyle(
              color: AppColors.textOutline.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildActivityCard(AnimalReport item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textOutline, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(6, 6),
            blurRadius: 0,
          ),
        ],
      ),
       child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(report: item)),
            ),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.textOutline, width: 2),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.background,
                backgroundImage: NetworkImage(item.imageUrl),
                onBackgroundImageError: (_, __) {},
              ),
            ),
            title: Text(
              item.apiName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textOutline,
              ),
            ),
            subtitle: Text(
              item.location,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.textOutline, width: 1.5),
              ),
               child: const Text(
                'Aktif',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOutline,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(report: item),
                      ),
                    ), 
                      icon: const Icon(Icons.visibility, size: 18),
                    label: const Text("Lihat"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textOutline,
                      side: const BorderSide(
                        color: AppColors.textOutline,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
