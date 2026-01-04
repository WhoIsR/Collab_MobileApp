import 'package:collab_mobile_app/presentation/pages/auth/login.dart';
import 'package:collab_mobile_app/presentation/pages/home/add_report_page.dart';
import 'package:collab_mobile_app/presentation/pages/profiles/profile_page.dart';
import 'package:collab_mobile_app/presentation/pages/profiles/profile_team_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collab_mobile_app/core/theme/app_colors.dart';
import 'package:collab_mobile_app/data/models/animal_report_model.dart';
import 'package:collab_mobile_app/data/services/auth_service.dart';
import 'package:collab_mobile_app/data/services/report_service.dart';
import 'package:collab_mobile_app/presentation/pages/home/my_activity_page.dart';
import 'package:collab_mobile_app/presentation/pages/home/explore_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  final ReportService _reportService = ReportService();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  List<AnimalReport> _reports = [];
  bool _isLoading = true;

  //
  final GlobalKey<MyActivityPageState> _activityKey = GlobalKey();
  final GlobalKey<ProfilePageState> _profileKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    final reports = await _reportService.getAllReports();
    if (!mounted) return;
    setState(() {
      _reports = reports;
      _isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  Future<void> _handleLogout() async {
    await _authService.signOut();
    if (mounted) {
      //mengatur supaya ni logout balik ke loggin page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
        (route) => false,
      );
    }
  }

  Future<void> _goToAddReport() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddReportPage()),
    );
    if (result == true) {
      _loadReports();
      _activityKey.currentState?.refresh();
      _profileKey.currentState?.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('PawsRes'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      drawer: _DashboardDrawer(
        currentUser: _currentUser,
        onLogout: _handleLogout,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _HomeView(
            isLoading: _isLoading,
            reports: _reports,
            onRefresh: _loadReports,
          ),
          ExplorePage(reports: _reports),
          MyActivityPage(key: _activityKey),
          ProfilePage(key: _profileKey),
          const Center(child: Text('Explore - Coming Soon')),
          const Center(child: Text('Activity - Coming Soon')),
          const Center(child: Text('Profile - Coming Soon')),
        ],
      ),
      bottomNavigationBar: _DashboardBottomNav(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _goToAddReport,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.textOutline),
            )
          : null,
    );
  }
}

class _DashboardDrawer extends StatelessWidget {
  final User? currentUser;
  final VoidCallback onLogout;

  const _DashboardDrawer({required this.currentUser, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              border: Border(
                bottom: BorderSide(color: AppColors.textOutline, width: 3),
              ),
            ),
            accountName: const Text(
              "PawsRes User",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textOutline,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              currentUser?.email ?? "guest@pawsres.com",
              style: const TextStyle(color: AppColors.textOutline),
            ),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.textOutline, width: 2),
              ),
              child: const CircleAvatar(
                backgroundColor: AppColors.surface,
                child: Icon(
                  Icons.person,
                  color: AppColors.textOutline,
                  size: 40,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.textOutline),
            title: const Text(
              'Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textOutline,
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.people, color: AppColors.textOutline),
            title: const Text(
              'Tim Pengembang',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textOutline,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileTeamPage()),
              );
            },
          ),
          const Divider(),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Keluar',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _DashboardBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const _DashboardBottomNav({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.textOutline, width: 3)),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        selectedItemColor: AppColors.textOutline,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  final bool isLoading;
  final List<AnimalReport> reports;
  final Future<void> Function() onRefresh;

  const _HomeView({
    required this.isLoading,
    required this.reports,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (reports.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, size: 80, color: AppColors.primary),
            SizedBox(height: 16),
            Text(
              'Belum ada laporan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textOutline,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) => _ReportCard(item: reports[index]),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final AnimalReport item;

  const _ReportCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.textOutline, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        // DetailPage belum ada, ini fungsinya buat liat detail laporan
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => DetailPage(report: item)),
          // );
        },
        borderRadius: BorderRadius.circular(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              child: Image.network(
                item.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text("🐱", style: TextStyle(fontSize: 50)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.apiName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOutline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.location,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
