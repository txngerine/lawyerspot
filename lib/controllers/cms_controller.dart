import 'package:get/get.dart';
import '../models/cms_model.dart';
import '../models/lawyer_model.dart';
import '../models/article_model.dart';
import '../models/qa_model.dart';
import '../services/cms_service.dart';

class CmsController extends GetxController {
  final cmsData = Rxn<CmsData>();
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  List<Lawyer> get topLawyers {
    final data = cmsData.value;
    if (data == null) return [];
    final sorted = List<Lawyer>.from(data.lawyers)
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(4).toList();
  }

  List<Article> get publishedArticles {
    final data = cmsData.value;
    if (data == null) return [];
    return data.articles.where((a) => a.status == 'published').toList();
  }

  List<QaPost> get publishedQaPosts {
    final data = cmsData.value;
    if (data == null) return [];
    return data.qaPosts.where((q) => q.status == 'published').toList();
  }

  Lawyer? lawyerBySlug(String slug) {
    final data = cmsData.value;
    if (data == null) return null;
    return data.lawyers.where((l) => l.slug == slug).firstOrNull;
  }

  PracticeArea? practiceAreaBySlug(String slug) {
    final data = cmsData.value;
    if (data == null) return null;
    return data.practiceAreas.where((p) => p.slug == slug).firstOrNull;
  }

  City? cityBySlug(String slug) {
    final data = cmsData.value;
    if (data == null) return null;
    return data.cities.where((c) => c.slug == slug).firstOrNull;
  }

  Article? articleBySlug(String slug) {
    final data = cmsData.value;
    if (data == null) return null;
    return data.articles.where((a) => a.slug == slug).firstOrNull;
  }

  QaPost? qaPostBySlug(String slug) {
    final data = cmsData.value;
    if (data == null) return null;
    return data.qaPosts.where((q) => q.slug == slug).firstOrNull;
  }

  SiteContent? get siteContent => cmsData.value?.siteContent;

  Future<void> fetchCms() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      cmsData.value = await Get.find<CmsService>().fetchCms();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
