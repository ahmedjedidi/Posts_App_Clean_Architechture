import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/exceptions.dart';
import 'package:posts_clean_architechture/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSources{
 Future<List<PostModel>> getCachedPosts();
 Future<Unit> cachePosts(List<PostModel> posts); 
}


class PostLocalDataSourcesImpl implements PostLocalDataSources{

  final SharedPreferences sharedPreferences;

  PostLocalDataSourcesImpl({required this.sharedPreferences});


  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List postModelToJson = posts
    .map<Map<String,dynamic>>((postModel) => postModel.toJson())
    .toList();
    sharedPreferences.setString("cached_posts", json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
   final jsonString= sharedPreferences.getString("cached_posts");

   if(jsonString != null){
    List decodeJsonData = json.decode(jsonString);
    List<PostModel> jsonToPostsModel = decodeJsonData
    .map<PostModel>((jsonPostsModel) => PostModel.fromjson(jsonPostsModel))
    .toList();
    return Future.value(jsonToPostsModel);
   }
   else{
   throw EmptyCacheException();
   }
  }

}