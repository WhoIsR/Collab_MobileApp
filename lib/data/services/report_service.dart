import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ReportService {
  // Ambil instance Supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  // Nama tabel di Supabase
  final String _tableName = 'animal_reports';

  // AMBIL SEMUA LAPORAN
  Future<List<AnimalReport>> getAllReports() async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      List<AnimalReport> reports = [];
      for (var item in response) {
        reports.add(AnimalReport.fromJson(item));
      }

      debugPrint('✓ Berhasil ambil ${reports.length} laporan');
      return reports;
    } catch (e) {
      debugPrint('✗ Error ambil laporan: $e');
      return [];
    }
  }

  // AMBIL LAPORAN BY USER
  Future<List<AnimalReport>> getReportsByUser(String userId) async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      List<AnimalReport> reports = [];
      for (var item in response) {
        reports.add(AnimalReport.fromJson(item));
      }

      return reports;
    } catch (e) {
      debugPrint('✗ Error ambil laporan user: $e');
      return [];
    }
  }

  // TAMBAH LAPORAN BARU
  Future<bool> addReport(AnimalReport report) async {
    try {
      debugPrint('📤 Mengirim data ke Supabase...');
      debugPrint('Data: ${report.toJson()}');

      await _supabase.from(_tableName).insert(report.toJson());

      debugPrint('✓ Laporan berhasil dikirim!');
      return true;
    } catch (e) {
      debugPrint('✗ Error tambah laporan: $e');
      debugPrint('Pastikan tabel "$_tableName" sudah dibuat di Supabase!');
      return false;
    }
  }

  // HAPUS LAPORAN
  Future<bool> deleteReport(String id) async {
    try {
      await _supabase.from(_tableName).delete().eq('id', id);
      debugPrint('✓ Laporan $id berhasil dihapus');
      return true;
    } catch (e) {
      debugPrint('✗ Error hapus laporan: $e');
      return false;
    }
  }

  // UPDATE LAPORAN
  Future<bool> updateReport(String id, AnimalReport report) async {
    try {
      await _supabase.from(_tableName).update(report.toJson()).eq('id', id);
      return true;
    } catch (e) {
      debugPrint('✗ Error update laporan: $e');
      return false;
    }
  }
}
