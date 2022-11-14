import 'package:posts_clean_architechture/core/errors/exceptions.dart';
import 'package:posts_clean_architechture/core/network/network_info.dart';
import 'package:posts_clean_architechture/features/posts/data/datasources/post_local_data_sources.dart';
import 'package:posts_clean_architechture/features/posts/data/datasources/post_remote_data_sources.dart';
import 'package:posts_clean_architechture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/features/posts/domain/repositories/post_repository.dart';


typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDataSources postRemoteDataSources;
  final PostLocalDataSources postLocalDataSources;
  final NetworkInfo networkInfo;
  PostsRepositoryImpl(
      {required this.postRemoteDataSources,
      required this.postLocalDataSources,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSources.getAllPosts();
        postLocalDataSources.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSources.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {

    PostModel postModel = PostModel( title: post.title, body: post.body);
     return getMessage(() {
    return postRemoteDataSources.addPost(postModel);
   });
  }

  @override
  Future<Either<Failure, Unit>> deletPost(int id) async{
    return getMessage(() {
    return postRemoteDataSources.deletePost(id);
   });
  }
  

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
   PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
   return getMessage(() {
    return postRemoteDataSources.updatePost(postModel);
   });
  }

  Future<Either<Failure, Unit>> getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected){
     try {
      deleteOrUpdateOrAddPost();
       return Right(unit);
     } on ServerException {
       return Left(ServerFailure());
     }
    }
    else{
      return Left(OfflineFailure());
    }
  }
}
