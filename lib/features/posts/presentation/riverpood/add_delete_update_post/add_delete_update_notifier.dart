import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/core/strings/failures.dart';
import 'package:posts_clean_architechture/core/strings/messages.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/update_post.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/add_delete_update_post/add_delete_update_state.dart';

class AddDeleteUpdatePostNotifier extends StateNotifier<AddDeleteUpdatePostState>{
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  AddDeleteUpdatePostNotifier({
    required this.addPostUseCase, 
    required this.deletePostUseCase,
    required this.updatePostUseCase}) : super(AddDeleteUpdatePostInitial());


  addPost(Post post) async {
    state = LoadingAddDeleteUpdatePostState();
    final failureOrDoneMessage = await addPostUseCase.call(post);
    failureOrDoneMessage.fold(
      (failure) => showFailureMessage(failure),
      (unit) => state = MessageAddDeleteUpdatePostState(message: ADD_SUCCESS_MESSAGE));
  }

  deletePost(int postId) async {
  state = LoadingAddDeleteUpdatePostState();
    final failureOrDoneMessage = await deletePostUseCase.call(postId);
    failureOrDoneMessage.fold(
      (failure) => showFailureMessage(failure),
      (unit) => state = MessageAddDeleteUpdatePostState(message: DELETE_SUCCESS_MESSAGE));
  }

  updatePost(Post post) async {
  state = LoadingAddDeleteUpdatePostState();
    final failureOrDoneMessage = await updatePostUseCase.call(post);
    failureOrDoneMessage.fold(
      (failure) => showFailureMessage(failure),
      (unit) => state = MessageAddDeleteUpdatePostState(message: UPDATE_SUCCESS_MESSAGE));
  }

  showFailureMessage(Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
      return state = ErrorAddDeleteUpdatePostState(message: SERVER_FAILURE_MESSAGE);
      case OfflineFailure: 
      return state = ErrorAddDeleteUpdatePostState(message: OFFLINE_FAILURE_MESSAGE);
      
      default:
      return state = ErrorAddDeleteUpdatePostState(message: "Unexpected Error , Please try again later.");
    }
}

}