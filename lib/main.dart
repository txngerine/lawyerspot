import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_flow.dart';
import 'screens/home_shell.dart';

void main() {
  runApp(const LawyerSpotApp());
}

class LawyerSpotApp extends StatelessWidget {
  const LawyerSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LawyerSpot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupFlow(),
        '/home': (context) => const HomeShell(),
      },
    );
  }
}
