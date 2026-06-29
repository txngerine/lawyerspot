import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/conversation_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  final _controller = Get.find<ConversationController>();

  @override
  void initState() {
    super.initState();
    _controller.loadConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandAppBar(showBack: true, title: 'Messages'),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.conversations.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.conversations.isEmpty) {
          return Center(
            child: Text('No conversations yet', style: AppText.bodyMd),
          );
        }
        return RefreshIndicator(
          onRefresh: _controller.loadConversations,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            itemCount: _controller.conversations.length,
            itemBuilder: (context, index) {
              final conv = _controller.conversations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SoftCard(
                  onTap: () {
                    _controller.selectConversation(conv);
                    Get.toNamed('/chat/${conv.id}');
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.navy.withOpacity(0.04),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            conv.userName.isNotEmpty
                                ? conv.userName[0].toUpperCase()
                                : '?',
                            style: AppText.titleLg.copyWith(color: AppColors.navy),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(conv.userName, style: AppText.titleLg),
                                ),
                                Text(
                                  conv.lastMessageAt,
                                  style: AppText.labelCaps.copyWith(fontSize: 10, color: AppColors.outline),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              conv.userEmail,
                              style: AppText.bodySm.copyWith(fontSize: 11, color: AppColors.outline),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    conv.lastMessage,
                                    style: AppText.bodySm,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (conv.unreadCount > 0) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.goldDark,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      conv.unreadCount > 99 ? '99+' : conv.unreadCount.toString(),
                                      style: AppText.labelCaps.copyWith(
                                        fontSize: 9,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
