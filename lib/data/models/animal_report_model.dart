/// Model untuk data laporan hewan.
/// TODO: Implementasi model lengkap sesuai struktur database.
class AnimalReportModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? description;
  final String? category;
  final String? imageUrl;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AnimalReportModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.category,
    this.imageUrl,
    this.location,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AnimalReportModel.fromJson(Map<String, dynamic> json) {
    return AnimalReportModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
