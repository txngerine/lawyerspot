import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../controllers/conversation_controller.dart';
import '../models/conversation_model.dart';
import '../theme/app_theme.dart';

class ChatDetailScreen extends StatefulWidget {
  final Conversation conversation;
  const ChatDetailScreen({super.key, required this.conversation});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _controller = Get.find<ConversationController>();
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.selectConversation(widget.conversation);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    _controller.sendMessage(widget.conversation.id, text).then((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.userName, style: AppText.titleLg),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_controller.currentMessages.isNotEmpty) {
            _scrollToBottom();
          }
        });

        return Column(
          children: [
            Expanded(
              child: _controller.isLoading.value && _controller.currentMessages.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : _controller.currentMessages.isEmpty
                      ? Center(child: Text('No messages yet', style: AppText.bodyMd))
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                          itemCount: _controller.currentMessages.length,
                          itemBuilder: (context, index) {
                            final msg = _controller.currentMessages[index];
                            final isLawyer = msg.senderType == 'lawyer';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Align(
                                alignment: isLawyer ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isLawyer ? AppColors.navy : AppColors.surfaceContainerHigh,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(16),
                                      topRight: const Radius.circular(16),
                                      bottomLeft: isLawyer ? const Radius.circular(16) : Radius.zero,
                                      bottomRight: isLawyer ? Radius.zero : const Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        msg.text,
                                        style: AppText.bodyMd.copyWith(
                                          color: isLawyer ? Colors.white : AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        msg.createdAt,
                                        style: AppText.labelCaps.copyWith(
                                          fontSize: 9,
                                          color: isLawyer
                                              ? Colors.white.withOpacity(0.6)
                                              : AppColors.outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardLowest,
                border: Border(top: BorderSide(color: AppColors.outlineVariant.withOpacity(0.3))),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send_rounded, color: AppColors.goldDark),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.goldDark.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
