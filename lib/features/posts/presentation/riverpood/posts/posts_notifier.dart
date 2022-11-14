import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/core/strings/failures.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/posts/posts_state.dart';

class PostsNotifier extends StateNotifier<PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsNotifier({required this.getAllPosts}) : super(InitialPostState()) {
    getPosts();
  }

  getPosts() async {
    final failureOrPosts = await getAllPosts.call();
    failureOrPosts.fold((failure) => {getFailureState(failure)},
        (posts) => {state = LoadedPostState(posts: posts)});
  }

  PostsState getFailureState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return state = ErrorPostsState(message: SERVER_FAILURE_MESSAGE);
      case EmptyCacheFailure:
        return state = ErrorPostsState(message: EMPTY_CACHE_FAILURE_MESSAGE);
      case OfflineFailure:
        return state = ErrorPostsState(message: OFFLINE_FAILURE_MESSAGE);

      default:
        return state = ErrorPostsState(
            message: "Unexpected Error , Please try again later.");
    }
  }
}
