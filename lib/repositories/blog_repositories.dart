import 'package:http/http.dart' as http;
import 'package:subspace/model/blog.dart';
import 'dart:convert';


class BlogRepository {
  final String apiUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String apiSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    final url = Uri.parse(apiUrl);
    final response = await http.get(
      url,
      headers: {
        'x-hasura-admin-secret': apiSecret,
      },
    );

    if (response.statusCode == 200) {
      List<Blog> blogs = (json.decode(response.body)['blogs'] as List)
          .map((data) => Blog.fromJson(data))
          .toList();
      return blogs;
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}
