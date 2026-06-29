class DashboardSummary {
  final int consultationsThisMonth;
  final int qaAnswersAllTime;
  final double profileQuality;
  final String greeting;
  final String? actionRequiredTitle;
  final String? actionRequiredBody;

  DashboardSummary({
    this.consultationsThisMonth = 0,
    this.qaAnswersAllTime = 0,
    this.profileQuality = 0.0,
    this.greeting = '',
    this.actionRequiredTitle,
    this.actionRequiredBody,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      DashboardSummary(
        consultationsThisMonth: json['consultations_this_month'] as int? ?? 0,
        qaAnswersAllTime: json['qa_answers_all_time'] as int? ?? 0,
        profileQuality: (json['profile_quality'] as num?)?.toDouble() ?? 0.0,
        greeting: json['greeting'] as String? ?? '',
        actionRequiredTitle: json['action_required_title'] as String?,
        actionRequiredBody: json['action_required_body'] as String?,
      );
}
