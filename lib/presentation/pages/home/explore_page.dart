import 'package:flutter/material.dart';
import 'package:uas_test/core/theme/app_colors.dart';
import 'package:uas_test/data/models/animal_report_model.dart';
import 'package:uas_test/presentation/pages/home/detail_page.dart';

class ExplorePage extends StatefulWidget {
  final List<AnimalReport> reports;

  const ExplorePage({super.key, this.reports = const []});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Controller untuk search
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // Kategori filter
  final List<String> categories = [
    "Semua",
    "Kucing",
    "Anjing",
    "Luka",
    "Hilang",
  ];
  String selectedCategory = "Semua";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

   // Hasil filter
  List<AnimalReport> get filteredReports {
    List<AnimalReport> result = widget.reports;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      result = result.where((item) {
        final query = _searchQuery.toLowerCase();
        return item.apiName.toLowerCase().contains(query) ||
            item.location.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query);
      }).toList();
    }

    // Filter by category
    if (selectedCategory != "Semua") {
      final keyword = categoryToKeyword(selectedCategory);
      result = result.where((item) {
        return item.apiName.toLowerCase().contains(keyword) ||
            item.description.toLowerCase().contains(keyword);
      }).toList();
    }

    return result;
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.textOutline, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x15000000),
                    offset: Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
               child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                style: const TextStyle(color: AppColors.textOutline),
                decoration: InputDecoration(
                  hintText: "Cari nama, lokasi, deskripsi...",
                  hintStyle: TextStyle(
                    color: AppColors.textOutline.withValues(alpha: 0.5),
                  ),
                   prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textOutline,
                  ),
                   suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.textOutline,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = "");
                          },
                        )
                        : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedCategory = category);
                    },
                     child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.textOutline,
                          width: 2,
                        ),
                         boxShadow: isSelected
                            ? const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(3, 3),
                                  blurRadius: 0,
                                ),
                              ]
                            : null,
                      ),
                       child: Text(
                        category,
                        style: TextStyle(
                          color: AppColors.textOutline,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Result count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  "${filteredReports.length} hasil ditemukan",
                  style: TextStyle(
                    color: AppColors.textOutline.withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

           // List Hasil
          Expanded(
            child: filteredReports.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 60,
                          color: AppColors.primary,
                        ),
