class ConsultationModel {
  final String id;
  final String clientName;
  final String? clientInitials;
  final String subject;
  final String? subjectIcon;
  final String dateLabel;
  final String timeLabel;
  final String actionLabel;
  final bool highlighted;
  final String? email;
  final String? phone;
  final String? reason;
  final List<DocumentModel> documents;
  final String status;

  ConsultationModel({
    required this.id,
    required this.clientName,
    this.clientInitials,
    required this.subject,
    this.subjectIcon,
    required this.dateLabel,
    required this.timeLabel,
    required this.actionLabel,
    this.highlighted = false,
    this.email,
    this.phone,
    this.reason,
    this.documents = const [],
    this.status = 'upcoming',
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        id: json['id'] as String,
        clientName: json['client_name'] as String,
        clientInitials: json['client_initials'] as String?,
        subject: json['subject'] as String,
        subjectIcon: json['subject_icon'] as String?,
        dateLabel: json['date_label'] as String,
        timeLabel: json['time_label'] as String,
        actionLabel: json['action_label'] as String,
        highlighted: json['highlighted'] as bool? ?? false,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        reason: json['reason'] as String?,
        documents: (json['documents'] as List<dynamic>?)
                ?.map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        status: json['status'] as String? ?? 'upcoming',
      );
}

class DocumentModel {
  final String id;
  final String name;
  final String size;
  final String addedDate;

  DocumentModel({
    required this.id,
    required this.name,
    required this.size,
    required this.addedDate,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        id: json['id'] as String,
        name: json['name'] as String,
        size: json['size'] as String,
        addedDate: json['added_date'] as String,
      );
}
