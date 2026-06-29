class QuestionModel {
  final String id;
  final String area;
  final int answers;
  final String title;
  final String preview;
  final String body;
  final String author;
  final String timeAgo;

  QuestionModel({
    required this.id,
    required this.area,
    required this.answers,
    required this.title,
    required this.preview,
    this.body = '',
    required this.author,
    required this.timeAgo,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json['id'] as String,
        area: json['area'] as String,
        answers: json['answers'] as int,
        title: json['title'] as String,
        preview: json['preview'] as String,
        body: json['body'] as String? ?? '',
        author: json['author'] as String,
        timeAgo: json['time_ago'] as String,
      );
}

class AnswerModel {
  final String id;
  final String lawyerName;
  final String? lawyerInitials;
  final String? lawyerTitle;
  final String? lawyerLocation;
  final String body;
  final int helpfulCount;
  final String createdAt;

  AnswerModel({
    required this.id,
    required this.lawyerName,
    this.lawyerInitials,
    this.lawyerTitle,
    this.lawyerLocation,
    required this.body,
    this.helpfulCount = 0,
    required this.createdAt,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        id: json['id'] as String,
        lawyerName: json['lawyer_name'] as String,
        lawyerInitials: json['lawyer_initials'] as String?,
        lawyerTitle: json['lawyer_title'] as String?,
        lawyerLocation: json['lawyer_location'] as String?,
        body: json['body'] as String,
        helpfulCount: json['helpful_count'] as int? ?? 0,
        createdAt: json['created_at'] as String,
      );
}

class MyAnswerModel {
  final String id;
  final String area;
  final String date;
  final int helpful;
  final String question;
  final String preview;

  MyAnswerModel({
    required this.id,
    required this.area,
    required this.date,
    required this.helpful,
    required this.question,
    required this.preview,
  });

  factory MyAnswerModel.fromJson(Map<String, dynamic> json) => MyAnswerModel(
        id: json['id'] as String,
        area: json['area'] as String,
        date: json['date'] as String,
        helpful: json['helpful'] as int,
        question: json['question'] as String,
        preview: json['preview'] as String,
      );
}
