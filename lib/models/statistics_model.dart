class StatisticsModel {
  final double rating;
  final int totalClients;
  final int responseRate;
  final double averageResponseHours;
  final int profileViews;
  final int reviewCount;
  final List<double> weeklyConsultations;

  StatisticsModel({
    this.rating = 0.0,
    this.totalClients = 0,
    this.responseRate = 0,
    this.averageResponseHours = 0.0,
    this.profileViews = 0,
    this.reviewCount = 0,
    this.weeklyConsultations = const [],
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      StatisticsModel(
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        totalClients: json['total_clients'] as int? ?? 0,
        responseRate: json['response_rate'] as int? ?? 0,
        averageResponseHours:
            (json['average_response_hours'] as num?)?.toDouble() ?? 0.0,
        profileViews: json['profile_views'] as int? ?? 0,
        reviewCount: json['review_count'] as int? ?? 0,
        weeklyConsultations: (json['weekly_consultations'] as List<dynamic>?)
                ?.map((e) => (e as num).toDouble())
                .toList() ??
            [],
      );
}
