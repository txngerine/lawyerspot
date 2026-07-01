import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/base_service.dart';
import 'services/cms_service.dart';
import 'services/auth_service.dart';
import 'services/profile_service.dart';
import 'services/article_service.dart';
import 'services/qa_service.dart';
import 'services/conversation_service.dart';
import 'services/section_service.dart';
import 'services/subscription_service.dart';
import 'services/statistics_service.dart';
import 'controllers/cms_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/article_controller.dart';
import 'controllers/qa_controller.dart';
import 'controllers/conversation_controller.dart';
import 'controllers/search_controller.dart' as app;
import 'controllers/section_controller.dart';
import 'controllers/subscription_controller.dart';
import 'controllers/statistics_controller.dart';
import 'controllers/navigation_controller.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_flow.dart';
import 'screens/home_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseService.init();

  // Services
  Get.put(CmsService());
  Get.put(AuthService());
  Get.put(ProfileService());
  Get.put(ArticleService());
  Get.put(QaService());
  Get.put(ConversationService());
  Get.put(SectionService());
  Get.put(SubscriptionService());
  Get.put(StatisticsService());

  // Controllers
  Get.put(CmsController());
  Get.put(AuthController());
  Get.put(ProfileController());
  Get.put(ArticleController());
  Get.put(QAController());
  Get.put(ConversationController());
  Get.put(app.SearchController());
  Get.put(SectionController());
  Get.put(SubscriptionController());
  Get.put(StatisticsController());
  Get.put(NavigationController());

  runApp(const LawyerSpotApp());
}

class LawyerSpotApp extends StatelessWidget {
  const LawyerSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LawyerSpot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupFlow()),
        GetPage(name: '/home', page: () => const HomeShell()),
      ],
    );
  }
}
