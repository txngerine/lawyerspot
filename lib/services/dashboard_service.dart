import '../config/api_config.dart';
import '../models/dashboard_model.dart';
import 'base_service.dart';

class DashboardService extends BaseService {
  Future<DashboardSummary> getSummary() async {
    final response = await get(ApiConfig.dashboardSummary);
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load dashboard');
    }
    return DashboardSummary.fromJson(response.body as Map<String, dynamic>);
  }
}
