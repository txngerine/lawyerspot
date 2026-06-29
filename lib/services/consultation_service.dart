import 'package:dio/dio.dart';
import '../models/consultation_model.dart';
import 'base_service.dart';

class ConsultationService {
  Future<List<ConsultationModel>> getConsultations(String status) async {
    final response = await BaseService.instance.dio.get(
      '/consultations',
      queryParameters: {'status': status},
    );
    final list = response.data as List<dynamic>;
    return list
        .map((e) => ConsultationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ConsultationModel> getConsultation(String id) async {
    final response =
        await BaseService.instance.dio.get('/consultations/$id');
    return ConsultationModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> updateNotes(String id, String notes) async {
    await BaseService.instance.dio.put('/consultations/$id/notes', data: {
      'notes': notes,
    });
  }
}
