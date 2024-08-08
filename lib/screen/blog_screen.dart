import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/blocks/blog_block.dart';
import 'package:subspace/blocks/blog_event.dart';
import 'package:subspace/blocks/blog_state.dart';
import 'package:subspace/repositories/blog_repositories.dart';
import 'package:subspace/widget/blog_card.dart';


class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(blogRepository: BlogRepository())..add(FetchBlogs()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('SubSpace'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BlogLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BlogLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: state.blogs.map((blog) => BlogCard(blog: blog)).toList(),
                ),
              );
            } else if (state is BlogError) {
              return Center(child: Text('Failed to load blogs'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
