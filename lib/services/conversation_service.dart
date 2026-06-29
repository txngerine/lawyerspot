import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../models/conversation_model.dart';
import 'base_service.dart';

class ConversationService {
  Future<List<Conversation>> listConversations() async {
    final response =
        await BaseService.instance.dio.get(ApiConfig.conversations);
    debugPrint('[Conversation] listConversations response: ${response.data}');
    final list = (response.data as Map<String, dynamic>)['conversations']
        as List<dynamic>;
    return list
        .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Message>> getMessages(int conversationId) async {
    final response = await BaseService.instance.dio
        .get(ApiConfig.conversationMessages(conversationId.toString()));
    debugPrint('[Conversation] getMessages response: ${response.data}');
    final list =
        (response.data as Map<String, dynamic>)['messages'] as List<dynamic>;
    return list
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Message> sendMessage(int conversationId, String text) async {
    debugPrint('[Conversation] sendMessage request data: {conversationId: $conversationId, text: $text}');
    final response = await BaseService.instance.dio.post(
      ApiConfig.conversationMessages(conversationId.toString()),
      data: SendMessageRequest(text: text).toJson(),
    );
    debugPrint('[Conversation] sendMessage response: ${response.data}');
    final data =
        (response.data as Map<String, dynamic>)['message'] as Map<String, dynamic>;
    return Message.fromJson(data);
  }

  Future<Map<String, dynamic>> markRead(int conversationId) async {
    debugPrint('[Conversation] markRead request conversationId: $conversationId');
    final response = await BaseService.instance.dio
        .post(ApiConfig.conversationRead(conversationId.toString()));
    debugPrint('[Conversation] markRead response: ${response.data}');
    return response.data as Map<String, dynamic>;
  }
}
