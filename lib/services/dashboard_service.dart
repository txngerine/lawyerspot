import 'package:dio/dio.dart';
import '../models/dashboard_model.dart';
import 'base_service.dart';

class DashboardService {
  Future<DashboardSummary> getSummary() async {
    final response = await BaseService.instance.dio.get('/dashboard/summary');
    return DashboardSummary.fromJson(response.data as Map<String, dynamic>);
  }
}
