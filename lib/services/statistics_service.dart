import '../config/api_config.dart';
import '../models/statistics_model.dart';
import 'base_service.dart';

class StatisticsService extends BaseService {
  Future<StatisticsModel> getOverview({String period = '30d'}) async {
    final response =
        await get(ApiConfig.statisticsOverview, query: {'period': period});
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load statistics');
    }
    return StatisticsModel.fromJson(response.body as Map<String, dynamic>);
  }
}
