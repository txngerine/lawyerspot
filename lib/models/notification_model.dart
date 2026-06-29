class NotificationModel {
  final String id;
  final String icon;
  final String title;
  final String subtitle;
  final String trailing;
  final bool unread;
  final String? action;

  NotificationModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.unread = false,
    this.action,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        icon: json['icon'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        trailing: json['trailing'] as String,
        unread: json['unread'] as bool? ?? false,
        action: json['action'] as String?,
      );
}
