import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architechture/core/errors/exceptions.dart';
import 'package:posts_clean_architechture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSources{
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
} 
const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourcesImpl implements PostRemoteDataSources{
  final http.Client client;

  PostRemoteDataSourcesImpl({required this.client});


  @override
  Future<List<PostModel>> getAllPosts() async{
   final response = await client.get(Uri.parse(BASE_URL+"/posts/"),
   headers: {
    "Content-Type" :"application/json"
   });

   if(response.statusCode ==200){
    List decodeString = jsonDecode(response.body) as List;
    List<PostModel> postsModels = decodeString
    .map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel))
    .toList();
     return postsModels;
   }else{
    throw ServerException();
   }
  }


  @override
  Future<Unit> addPost(PostModel post) async{
    final body = {
      "title" : post.title,
      "body" : post.body
    };
    final response = await client.post(Uri.parse(BASE_URL+"/posts/"),body:body);

    if(response.statusCode == 201){
     return Future.value(unit);   
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await http.delete(Uri.parse(BASE_URL+"/posts/${postId.toString()}"),
    headers: {"Content-Type" :"application/json"});
    if(response.statusCode == 200){
    return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> updatePost(PostModel post) async {
    final body = {
      "title":post.title,
      "body": post.body
    };
    final response = await client.patch(Uri.parse(BASE_URL+"/posts/${post.id.toString()}"));
    if(response.statusCode == 200){
      return Future.value(unit);
    }
    else{
      throw ServerException();
    }
  }

}