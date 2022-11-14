import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';

abstract class PostsRepository{
  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,Unit>> addPost(Post post);
  Future<Either<Failure,Unit>> deletPost(int id);
  Future<Either<Failure,Unit>> updatePost(Post post);
}