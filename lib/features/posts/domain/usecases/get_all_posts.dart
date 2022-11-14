import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/domain/repositories/post_repository.dart';

class GetAllPostsUseCase {
final PostsRepository postsRepository;

GetAllPostsUseCase(this.postsRepository);

Future<Either<Failure,List<Post>>> call() async{
  return await postsRepository.getAllPosts();
}

}