class AnimalReport {
  final String id;
  final String apiName; // Nama Hewan
  final String imageUrl; // URL Gambar
  final String location; // Lokasi ditemukan
  final String description; // Deskripsi kondisi
  final String contactWa; // Nomor WA Pelapor
  final String? userId; // ID User yang buat laporan
  final DateTime? createdAt; // Waktu dibuat

  AnimalReport({
    required this.id,
    required this.apiName,
    required this.imageUrl,
    required this.location,
    required this.description,
    required this.contactWa,
    this.userId,
    this.createdAt,
  });

  factory AnimalReport.fromJson(Map<String, dynamic> json) {
    return AnimalReport(
      id: json['id'].toString(),
      apiName: json['api_name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      contactWa: json['contact_wa'] ?? '',
      userId: json['user_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'api_name': apiName,
      'image_url': imageUrl,
      'location': location,
      'description': description,
      'contact_wa': contactWa,
      'user_id': userId,
    };
  }
}
