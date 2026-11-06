import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  PostService({http.Client? client}) : _client = client ?? http.Client();

  static final Uri _baseUrl =
      Uri.parse('https://jsonplaceholder.typicode.com');

  final http.Client _client;

  Future<List<Post>> fetchPosts() async {
    final address = _baseUrl.resolve('/posts');
    final response = await _client.get(address);
    _checkStatus(response);

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Format daftar pengumuman tidak valid.');
    }
    return decoded
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Post> createPost({
    required String title,
    required String body,
  }) async {
    final address = _baseUrl.resolve('/posts');
    final response = await _client.post(
      address,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
    );
    _checkStatus(response);

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Format pengumuman baru tidak valid.');
    }
    return Post.fromJson(decoded);
  }

  Future<List<Map<String, dynamic>>> fetchComments(int postId) async {
    final address = _baseUrl.resolve('/posts/$postId/comments');
    final response = await _client.get(address);
    _checkStatus(response);

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Format daftar komentar tidak valid.');
    }
    return decoded
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
  }

  void _checkStatus(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(
        'Permintaan gagal dengan status ${response.statusCode}.',
        response.request?.url,
      );
    }
  }

  void dispose() {
    _client.close();
  }
}