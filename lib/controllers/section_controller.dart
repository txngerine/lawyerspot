import 'package:get/get.dart';
import '../models/section_model.dart';
import '../services/section_service.dart';

class SectionController extends GetxController {
  final sections = <LegalSection>[].obs;
  final currentSection = Rxn<LegalSection>();
  final sectionType = 'ipc'.obs;
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  Future<void> loadSections(String type) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      sections.value = await Get.find<SectionService>().getSections(type);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSection(String slug) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      currentSection.value = await Get.find<SectionService>().getSection(slug);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void switchType(String type) {
    sectionType.value = type;
    loadSections(type);
  }
}
