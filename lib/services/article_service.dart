import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/article_model.dart';
import 'base_service.dart';

class ArticleService {
  Future<List<Article>> listArticles() async {
    final response = await BaseService.instance.dio.get(ApiConfig.lawyerArticles);
    debugPrint('[Article] listArticles response: ${response.data}');
    final list = (response.data as Map<String, dynamic>)['articles'] as List<dynamic>;
    return list.map((e) => Article.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Article> getArticle(String slug) async {
    final response = await BaseService.instance.dio.get(ApiConfig.lawyerArticle(slug));
    debugPrint('[Article] getArticle response: ${response.data}');
    final data = (response.data as Map<String, dynamic>)['article'] as Map<String, dynamic>;
    return Article.fromJson(data);
  }

  Future<Article> createArticle(Map<String, dynamic> data) async {
    debugPrint('[Article] createArticle request data: $data');
    final response = await BaseService.instance.dio.post(
      ApiConfig.lawyerArticles,
      data: data,
    );
    debugPrint('[Article] createArticle response: ${response.data}');
    final article =
        (response.data as Map<String, dynamic>)['article'] as Map<String, dynamic>;
    return Article.fromJson(article);
  }

  Future<Article> updateArticle(String slug, Map<String, dynamic> data) async {
    debugPrint('[Article] updateArticle request data: $data');
    final response = await BaseService.instance.dio.patch(
      ApiConfig.lawyerArticle(slug),
      data: data,
    );
    debugPrint('[Article] updateArticle response: ${response.data}');
    final article =
        (response.data as Map<String, dynamic>)['article'] as Map<String, dynamic>;
    return Article.fromJson(article);
  }

  Future<Map<String, dynamic>> deleteArticle(String slug) async {
    debugPrint('[Article] deleteArticle request slug: $slug');
    final response = await BaseService.instance.dio.delete(ApiConfig.lawyerArticle(slug));
    debugPrint('[Article] deleteArticle response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }
}
