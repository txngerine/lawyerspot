import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';

class ArticleController extends GetxController {
  final articles = <Article>[].obs;
  final currentArticle = Rxn<Article>();
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  Future<void> loadArticles() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      articles.value = await Get.find<ArticleService>().listArticles();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadArticle(String slug) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      currentArticle.value = await Get.find<ArticleService>().getArticle(slug);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createArticle(Map<String, dynamic> data) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<ArticleService>().createArticle(data);
      await loadArticles();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateArticle(String slug, Map<String, dynamic> data) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<ArticleService>().updateArticle(slug, data);
      await loadArticles();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteArticle(String slug) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Get.find<ArticleService>().deleteArticle(slug);
      await loadArticles();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
