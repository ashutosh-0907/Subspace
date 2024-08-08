import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:subspace/blocks/blog_event.dart';
import 'package:subspace/blocks/blog_state.dart';
import 'package:subspace/repositories/blog_repositories.dart';



class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;

  BlogBloc({required this.blogRepository}) : super(BlogInitial());

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    if (event is FetchBlogs) {
      yield BlogLoading();
      try {
        final blogs = await blogRepository.fetchBlogs();
        yield BlogLoaded(blogs: blogs);
      } catch (_) {
        yield BlogError();
      }
    }
  }
}
