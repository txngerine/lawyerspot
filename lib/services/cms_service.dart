import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/cms_model.dart';
import 'base_service.dart';

class CmsService {
  Future<CmsData> fetchCms() async {
    final response = await BaseService.instance.dio.get(ApiConfig.cms);
    return CmsData.fromJson(response.data as Map<String, dynamic>);
  }
}
