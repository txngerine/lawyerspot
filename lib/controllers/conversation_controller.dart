import 'package:get/get.dart';
import '../models/conversation_model.dart';
import '../services/conversation_service.dart';

class ConversationController extends GetxController {
  final conversations = <Conversation>[].obs;
  final currentMessages = <Message>[].obs;
  final activeConversation = Rxn<Conversation>();
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();

  Future<void> loadConversations() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      conversations.value = await Get.find<ConversationService>().listConversations();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMessages(int convId) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      currentMessages.value = await Get.find<ConversationService>().getMessages(convId);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(int convId, String text) async {
    errorMessage.value = null;
    try {
      await Get.find<ConversationService>().sendMessage(convId, text);
      await loadMessages(convId);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<void> markRead(int convId) async {
    try {
      await Get.find<ConversationService>().markRead(convId);
      await loadConversations();
    } catch (_) {}
  }

  Future<void> selectConversation(Conversation c) async {
    activeConversation.value = c;
    await loadMessages(c.id);
    if (c.unreadCount > 0) {
      await markRead(c.id);
    }
  }
}
