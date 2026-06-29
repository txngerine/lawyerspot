class Article {
  final String slug;
  final String title;
  final String excerpt;
  final String category;
  final String author;
  final String date;
  final String readTime;
  final String image;
  final bool trending;
  final String status;
  final String content;
  final String lawyerId;

  Article({
    this.slug = '',
    this.title = '',
    this.excerpt = '',
    this.category = '',
    this.author = '',
    this.date = '',
    this.readTime = '',
    this.image = '',
    this.trending = false,
    this.status = 'published',
    this.content = '',
    this.lawyerId = '',
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        slug: json['slug'] as String? ?? '',
        title: json['title'] as String? ?? '',
        excerpt: json['excerpt'] as String? ?? '',
        category: json['category'] as String? ?? '',
        author: json['author'] as String? ?? '',
        date: json['date'] as String? ?? '',
        readTime: json['readTime'] as String? ?? '',
        image: json['image'] as String? ?? '',
        trending: json['trending'] as bool? ?? false,
        status: json['status'] as String? ?? 'published',
        content: json['content'] as String? ?? '',
        lawyerId: json['lawyerId'] as String? ?? '',
      );
}
