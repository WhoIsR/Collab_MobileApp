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