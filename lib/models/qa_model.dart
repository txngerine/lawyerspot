class QaPost {
  final String id;
  final String title;
  final String excerpt;
  final String category;
  final int answers;
  final int views;
  final String slug;
  final String status;
  final String content;

  QaPost({
    this.id = '',
    this.title = '',
    this.excerpt = '',
    this.category = '',
    this.answers = 0,
    this.views = 0,
    this.slug = '',
    this.status = 'published',
    this.content = '',
  });

  factory QaPost.fromJson(Map<String, dynamic> json) => QaPost(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        excerpt: json['excerpt'] as String? ?? '',
        category: json['category'] as String? ?? '',
        answers: json['answers'] as int? ?? 0,
        views: json['views'] as int? ?? 0,
        slug: json['slug'] as String? ?? '',
        status: json['status'] as String? ?? 'published',
        content: json['content'] as String? ?? '',
      );
}

class Answer {
  final String id;
  final String lawyerId;
  final String lawyerName;
  final String body;
  final String status;
  final String createdAt;
  final String? updatedAt;
  final String? questionTitle;
  final String? questionSlug;
  final String? questionCategory;
  final String? qaPostId;

  Answer({
    this.id = '',
    this.lawyerId = '',
    this.lawyerName = '',
    this.body = '',
    this.status = 'published',
    this.createdAt = '',
    this.updatedAt,
    this.questionTitle,
    this.questionSlug,
    this.questionCategory,
    this.qaPostId,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json['id'] as String? ?? '',
        lawyerId: json['lawyerId'] as String? ?? '',
        lawyerName: json['lawyerName'] as String? ?? '',
        body: json['body'] as String? ?? '',
        status: json['status'] as String? ?? 'published',
        createdAt: json['createdAt'] as String? ?? '',
        updatedAt: json['updatedAt'] as String?,
        questionTitle: json['questionTitle'] as String?,
        questionSlug: json['questionSlug'] as String?,
        questionCategory: json['questionCategory'] as String?,
        qaPostId: json['qaPostId'] as String?,
      );
}

class QuestionWithAnswer {
  final QaPost question;
  final Answer? myAnswer;

  QuestionWithAnswer({required this.question, this.myAnswer});

  factory QuestionWithAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionWithAnswer(
        question:
            QaPost.fromJson(json['question'] as Map<String, dynamic>),
        myAnswer: json['myAnswer'] != null
            ? Answer.fromJson(json['myAnswer'] as Map<String, dynamic>)
            : null,
      );
}

class QaDetail {
  final QaPost question;
  final List<Answer> answers;

  QaDetail({required this.question, this.answers = const []});

  factory QaDetail.fromJson(Map<String, dynamic> json) => QaDetail(
        question:
            QaPost.fromJson(json['question'] as Map<String, dynamic>),
        answers: (json['answers'] as List<dynamic>?)
                ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class QuestionListItem {
  final String id;
  final String slug;
  final String title;
  final String excerpt;
  final String category;
  final int answers;
  final int views;
  final String status;
  final bool answeredByMe;

  QuestionListItem({
    this.id = '',
    this.slug = '',
    this.title = '',
    this.excerpt = '',
    this.category = '',
    this.answers = 0,
    this.views = 0,
    this.status = 'published',
    this.answeredByMe = false,
  });

  factory QuestionListItem.fromJson(Map<String, dynamic> json) =>
      QuestionListItem(
        id: json['id'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        excerpt: json['excerpt'] as String? ?? '',
        category: json['category'] as String? ?? '',
        answers: json['answers'] as int? ?? 0,
        views: json['views'] as int? ?? 0,
        status: json['status'] as String? ?? 'published',
        answeredByMe: json['answeredByMe'] as bool? ?? false,
      );
}
