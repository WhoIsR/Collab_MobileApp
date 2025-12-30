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