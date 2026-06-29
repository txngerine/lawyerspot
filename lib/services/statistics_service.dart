import 'package:dio/dio.dart';
import '../models/statistics_model.dart';
import 'base_service.dart';

class StatisticsService {
  Future<StatisticsModel> getOverview({String period = '30d'}) async {
    final response = await BaseService.instance.dio.get(
      '/statistics/overview',
      queryParameters: {'period': period},
    );
    return StatisticsModel.fromJson(response.data as Map<String, dynamic>);
  }
}
