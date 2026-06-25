import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'consultations_list_screen.dart';
import 'qa_browse_screen.dart';
import 'edit_profile_screen.dart';
import 'account_screen.dart';

/// Wraps the five primary destinations (Dashboard, Consultations, Q&A,
/// Profile, Account) behind a persistent bottom navigation bar, matching
/// the BottomNavBar present on every main screen of the HTML prototype.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _pages = [
    DashboardScreen(),
    ConsultationsListScreen(),
    QABrowseScreen(),
    EditProfileScreen(),
    AccountScreen(),
  ];

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.event_note_outlined), activeIcon: Icon(Icons.event_note), label: 'Consultations'),
    BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined), activeIcon: Icon(Icons.quiz), label: 'Q&A'),
    BottomNavigationBarItem(icon: Icon(Icons.person_pin_outlined), activeIcon: Icon(Icons.person_pin), label: 'Profile'),
    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: _items,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
