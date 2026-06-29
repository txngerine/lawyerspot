class LegalSection {
  final int id;
  final String type;
  final String sectionNumber;
  final String title;
  final String slug;
  final String body;
  final String punishment;
  final String category;
  final String status;
  final int displayOrder;
  final String createdAt;
  final String updatedAt;

  LegalSection({
    this.id = 0,
    this.type = '',
    this.sectionNumber = '',
    this.title = '',
    this.slug = '',
    this.body = '',
    this.punishment = '',
    this.category = '',
    this.status = 'active',
    this.displayOrder = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory LegalSection.fromJson(Map<String, dynamic> json) => LegalSection(
        id: json['id'] as int? ?? 0,
        type: json['type'] as String? ?? '',
        sectionNumber: json['sectionNumber'] as String? ?? '',
        title: json['title'] as String? ?? '',
        slug: json['slug'] as String? ?? '',
        body: json['body'] as String? ?? '',
        punishment: json['punishment'] as String? ?? '',
        category: json['category'] as String? ?? '',
        status: json['status'] as String? ?? 'active',
        displayOrder: json['displayOrder'] as int? ?? 0,
        createdAt: json['createdAt'] as String? ?? '',
        updatedAt: json['updatedAt'] as String? ?? '',
      );
}
