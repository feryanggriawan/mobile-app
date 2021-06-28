part of 'blog_cubit.dart';

abstract class BlogState extends Equatable {
  const BlogState();
}

class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  BlogLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}

class BlogLoadingFailed extends BlogState {
  final String message;

  BlogLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
