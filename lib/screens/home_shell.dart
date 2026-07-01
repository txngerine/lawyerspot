import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'conversation_list_screen.dart';
import '../screens/qa_browse_screen.dart';
import '../screens/profile_screen.dart';
import 'account_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _pages = [
    DashboardScreen(),
    ConversationListScreen(),
    QABrowseScreen(),
    ProfileScreen(),
    AccountScreen(),
  ];

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), activeIcon: Icon(Icons.chat), label: 'Messages'),
    BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined), activeIcon: Icon(Icons.quiz), label: 'Q&A'),
    BottomNavigationBarItem(icon: Icon(Icons.person_pin_outlined), activeIcon: Icon(Icons.person_pin), label: 'Profile'),
    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: _items,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
