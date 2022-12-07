import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_clean_architechture/core/errors/exceptions.dart';
import 'package:posts_clean_architechture/features/posts/data/datasources/post_remote_data_sources.dart';
import 'package:posts_clean_architechture/features/posts/data/models/post_model.dart';

import 'posts_test.mocks.dart';

class PostRemoteDataSourcesTest extends Mock implements PostRemoteDataSources {}

@GenerateMocks([PostRemoteDataSourcesTest])
void main() {
  group("fetch posts", () {
    late MockPostRemoteDataSourcesTest mockpostRemoteDataSourcesTest;
    late PostModel post;
    setUpAll(() {
      mockpostRemoteDataSourcesTest = MockPostRemoteDataSourcesTest();
      post = PostModel(id: 1, title: "test title", body: "test body");
    });

    //test get All Post
    test("returns list Of Posts if the Future completes successfull", () async {
      final model = <PostModel>[];
      when(mockpostRemoteDataSourcesTest.getAllPosts()).thenAnswer((_) async {
        return model;
      });
      final res = await mockpostRemoteDataSourcesTest.getAllPosts();
      expect(res, isA<List<PostModel>>());
      expect(res, model);
    });

    test('test getAllPoststhrows Exception', () {
      when(mockpostRemoteDataSourcesTest.getAllPosts()).thenAnswer((_) async {
        throw ServerException();
      });
      final res = mockpostRemoteDataSourcesTest.getAllPosts();
      expect(res, throwsException);
    });

    //test Add post
    test("test add Post if the Future completes successfull", () async {
      when(mockpostRemoteDataSourcesTest.addPost(post)).thenAnswer((_) async {
        return unit;
      });
      final res = await mockpostRemoteDataSourcesTest.addPost(post);
      expect(res, unit);
    });

    test('test add post throws Exception', () {
      when(mockpostRemoteDataSourcesTest.addPost(post)).thenAnswer((_) async {
        throw ServerException();
      });
      final res = mockpostRemoteDataSourcesTest.addPost(post);
      expect(res, throwsException);
    });

    //test delete Post
    test("test delete Post if the Future completes successfull", () async {
      when(mockpostRemoteDataSourcesTest.deletePost(1)).thenAnswer((_) async {
        return unit;
      });
      final res = await mockpostRemoteDataSourcesTest.deletePost(1);
      expect(res, unit);
    });

    test('test delete post throws Exception', () {
      when(mockpostRemoteDataSourcesTest.deletePost(1)).thenAnswer((_) async {
        throw ServerException();
      });
      final res = mockpostRemoteDataSourcesTest.deletePost(1);
      expect(res, throwsException);
    });

    //test update Post
    test("test update Post if the Future completes successfull", () async {
      when(mockpostRemoteDataSourcesTest.updatePost(post))
          .thenAnswer((_) async {
        return unit;
      });
      final res = await mockpostRemoteDataSourcesTest.updatePost(post);
      expect(res, unit);
    });

    test('test update post throws Exception', () {
      when(mockpostRemoteDataSourcesTest.updatePost(post))
          .thenAnswer((_) async {
        throw ServerException();
      });
      final res = mockpostRemoteDataSourcesTest.updatePost(post);
      expect(res, throwsException);
    });
  });
}
