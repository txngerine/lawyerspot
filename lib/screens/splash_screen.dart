import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../controllers/cms_controller.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _initApp();
  }

  Future<void> _initApp() async {
    final cms = Get.find<CmsController>();
    final auth = Get.find<AuthController>();

    await Future.wait([
      cms.fetchCms(),
      auth.checkSession(),
    ]);

    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;
    if (auth.isLoggedIn.value) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyContainer,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pushReplacementNamed('/login'),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.goldLight.withOpacity(0.06),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Column(
                      children: [
                        Text(
                          'LawyerSpot',
                          style: GoogleFonts.playfairDisplay(
                            fontWeight: FontWeight.w700,
                            fontSize: 48,
                            color: AppColors.gold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your Digital Chambers',
                          style: AppText.titleLg.copyWith(
                            color: AppColors.goldLight.withOpacity(0.8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                FadeTransition(
                  opacity: _fade,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: AppColors.navy,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, size: 12, color: AppColors.gold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'VERIFIED LEGAL PROFESSIONALS ONLY',
                          style: AppText.labelCaps.copyWith(
                            color: AppColors.goldLight.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
