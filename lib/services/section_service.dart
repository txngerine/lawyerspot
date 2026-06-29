import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/section_model.dart';
import 'base_service.dart';

class SectionService {
  Future<List<LegalSection>> getSections(String type) async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.sections(type));
    final list = response.data as List<dynamic>;
    return list
        .map((e) => LegalSection.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<LegalSection> getSection(String slug) async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.section(slug));
    return LegalSection.fromJson(response.data as Map<String, dynamic>);
  }
}
