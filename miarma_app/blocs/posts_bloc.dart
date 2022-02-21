import 'package:rxdart/rxdart.dart';
import '../models/post_model.dart';
import '../resources/repository_post.dart';

class PostsBloc {
  final _repository = RepositoryPost();
  final _postFetcher = PublishSubject<PostModel>();

  Observable<PostModel> get allMovies => _postFetcher.stream;

  fetchAllPosts() async {
    PostModel itemModel = await _repository.fetchAllPost();
    _postFetcher.sink.add(itemModel);
  }

  dispose() {
    _postFetcher.close();
  }
}

final bloc = PostsBloc();
