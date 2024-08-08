import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:subspace/bloc_detail.dart';
import 'package:subspace/model/class.dart';
import 'dart:convert';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<Blog> _blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    final url = Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs');
    final response = await http.get(
      url,
      headers: {
        'x-hasura-admin-secret':
            '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6',
      },
    );

    if (response.statusCode == 200) {
      List<Blog> blogs = (json.decode(response.body)['blogs'] as List)
          .map((data) => Blog.fromJson(data))
          .toList();
      setState(() {
        _blogs = blogs;
      });
    } else {
      print('Failed to load blogs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SubSpace',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: _blogs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: _blogs.map((blog) {
                  return ListTile(
                    leading: Image.network(blog.imageUrl),
                    title: Text(blog.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
    );
  }
}
