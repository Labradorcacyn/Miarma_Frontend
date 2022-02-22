import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/post_model.dart';
import '../../resources/repository_post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final RepositoryPost repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<FetchPostsPublicEvent>(_postsFetched);
  }

  void _postsFetched(
      FetchPostsPublicEvent event, Emitter<PostState> emit) async {
    try {
      final movies = await repository.fetchAllPost();
      emit(PostFetched(movies));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
