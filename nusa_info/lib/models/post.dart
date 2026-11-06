class Post {
  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  final int id;
  final int userId;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: _asInt(json['id'], 'id'),
      userId: _asInt(json['userId'], 'userId'),
      title: _asString(json['title'], 'title'),
      body: _asString(json['body'], 'body'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  static int _asInt(Object? value, String field) {
    if (value is int) {
      return value;
    }
    throw FormatException('Field "$field" harus berupa angka.');
  }

  static String _asString(Object? value, String field) {
    if (value is String) {
      return value;
    }
    throw FormatException('Field "$field" harus berupa teks.');
  }
}
