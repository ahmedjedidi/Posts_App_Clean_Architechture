import 'package:equatable/equatable.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class InitialPostState extends PostsState{}

class LoadedPostState extends PostsState{
 final List<Post> posts;

  LoadedPostState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class ErrorPostsState extends PostsState{
final String message;

  ErrorPostsState({required this.message});

  @override
  List<Object?> get props => [message];

}