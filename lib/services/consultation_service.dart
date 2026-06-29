import '../config/api_config.dart';
import '../models/consultation_model.dart';
import 'base_service.dart';

class ConsultationService extends BaseService {
  Future<List<ConsultationModel>> getConsultations(String status) async {
    final response = await get(ApiConfig.consultations, query: {'status': status});
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load consultations');
    }
    final list = response.body as List<dynamic>;
    return list
        .map((e) => ConsultationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ConsultationModel> getConsultation(String id) async {
    final response = await get(ApiConfig.consultation(id));
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to load consultation');
    }
    return ConsultationModel.fromJson(response.body as Map<String, dynamic>);
  }

  Future<void> updateNotes(String id, String notes) async {
    final response = await put(ApiConfig.consultationNotes(id), {'notes': notes});
    if (response.status.hasError) {
      throw Exception(response.statusText ?? 'Failed to save notes');
    }
  }
}
