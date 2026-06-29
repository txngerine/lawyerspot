class SearchResult {
  final String type;
  final String title;
  final String excerpt;
  final String href;

  SearchResult({
    required this.type,
    required this.title,
    this.excerpt = '',
    this.href = '',
  });
}
