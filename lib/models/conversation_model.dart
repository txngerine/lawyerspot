class Conversation {
  final int id;
  final String userId;
  final String userName;
  final String userEmail;
  final String lastMessage;
  final String lastMessageAt;
  final int unreadCount;

  Conversation({
    this.id = 0,
    this.userId = '',
    this.userName = '',
    this.userEmail = '',
    this.lastMessage = '',
    this.lastMessageAt = '',
    this.unreadCount = 0,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json['id'] as int? ?? 0,
        userId: json['userId'] as String? ?? '',
        userName: json['userName'] as String? ?? '',
        userEmail: json['userEmail'] as String? ?? '',
        lastMessage: json['lastMessage'] as String? ?? '',
        lastMessageAt: json['lastMessageAt'] as String? ?? '',
        unreadCount: json['unreadCount'] as int? ?? 0,
      );
}

class Message {
  final int id;
  final String senderId;
  final String senderType;
  final String text;
  final String createdAt;
  final bool isRead;

  Message({
    this.id = 0,
    this.senderId = '',
    this.senderType = '',
    this.text = '',
    this.createdAt = '',
    this.isRead = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'] as int? ?? 0,
        senderId: json['senderId'] as String? ?? '',
        senderType: json['senderType'] as String? ?? '',
        text: json['text'] as String? ?? '',
        createdAt: json['createdAt'] as String? ?? '',
        isRead: json['isRead'] as bool? ?? false,
      );
}

class SendMessageRequest {
  final String text;

  SendMessageRequest({required this.text});

  Map<String, dynamic> toJson() => {'text': text};
}
