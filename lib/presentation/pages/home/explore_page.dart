import 'package:flutter/material.dart';
import 'package:uas_test/core/theme/app_colors.dart';
import 'package:uas_test/data/models/animal_report_model.dart';
import 'package:uas_test/presentation/pages/home/detail_page.dart';

class ExplorePage extends StatefulWidget {
  final List<AnimalReport> reports;

  const ExplorePage({super.key, this.reports = const []});