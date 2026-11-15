class CafeInfo {
  const CafeInfo({
    required this.id,
    required this.title,
    required this.summary,
    required this.publishedAt,
  });

  final String id;
  final String title;
  final String summary;
  final String publishedAt;

  factory CafeInfo.fromJson(Map<String, dynamic> json) => CafeInfo(
        id: json['id'] as String,
        title: json['title'] as String,
        summary: json['summary'] as String,
        publishedAt: json['publishedAt'] as String,
      );
}
