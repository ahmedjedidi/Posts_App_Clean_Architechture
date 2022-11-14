import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/domain/repositories/post_repository.dart';

class AddPostUseCase {
final PostsRepository postsRepository;

  AddPostUseCase(this.postsRepository);

  Future<Either<Failure,Unit>> call(Post post) async{
    return  await postsRepository.addPost(post);
  }

}