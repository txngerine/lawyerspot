import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/cms_model.dart';
import 'base_service.dart';

class CmsService {
  Future<CmsData> fetchCms() async {
    final response = await BaseService.instance.dio.get(ApiConfig.cms);
    debugPrint('[CMS] fetchCms response: ${response.data}');
    return CmsData.fromJson(response.data as Map<String, dynamic>);
  }
}
