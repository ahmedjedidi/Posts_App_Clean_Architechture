 import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/features/posts/domain/repositories/post_repository.dart';

class DeletePostUseCase{
  final PostsRepository postsRepository;

  DeletePostUseCase(this.postsRepository);

  Future<Either<Failure,Unit>> call(int postId) async {
    return await postsRepository.deletPost(postId);
  }
 }