part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFetched extends PostState {
  final List<PostModel> posts;

  const PostFetched(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostFetchError extends PostState {
  final String message;
  const PostFetchError(this.message);

  @override
  List<Object> get props => [message];
}

class PostOneFetched extends PostState {}

class PostOneFetchError extends PostState {}
