import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/domain/repositories/post_repository.dart';

class UpdatePostUseCase {
final PostsRepository postsRepository;

  UpdatePostUseCase(this.postsRepository);

  Future<Either<Failure,Unit>> call(Post post) async{
    return await postsRepository.updatePost(post);
  }

}