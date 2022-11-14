import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/core/strings/failures.dart';
import 'package:posts_clean_architechture/core/strings/messages.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architechture/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddDeleteUpdatePostBloc({
  required this.addPost,
  required this.deletePost,
  required this.updatePost}) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async{
      if (event is AddPostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrSuccessPostState(failureOrDoneMessage,ADD_SUCCESS_MESSAGE));
      }
      else if (event is DeletePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrSuccessPostState(failureOrDoneMessage,DELETE_SUCCESS_MESSAGE));
      }
      else if (event is UpdatePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrSuccessPostState(failureOrDoneMessage,UPDATE_SUCCESS_MESSAGE));
      }
    });
  }

 AddDeleteUpdatePostState _eitherDoneMessageOrSuccessPostState(Either<Failure, Unit> either,String message){
  return either.fold((failure) => ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
   (_) => MessageAddDeleteUpdatePostState(message: message));
  }

    String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
      case OfflineFailure: 
      return OFFLINE_FAILURE_MESSAGE;  
      
      default:
      return "Unexpected Error , Please try again later.";
    }
  }
}
