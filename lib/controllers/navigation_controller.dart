import 'package:get/get.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  void goToTab(int index) => currentIndex.value = index;
}
