import 'package:collab_mobile_app/core/theme/app_colors.dart';
import 'package:collab_mobile_app/data/services/auth_service.dart';
import 'package:collab_mobile_app/presentation/pages/auth/register_page.dart';
import 'package:collab_mobile_app/presentation/pages/home/dashboard_page.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State
  bool _isLoading = false;
  final AuthService _authService = AuthService();

 