
import 'package:flutter/material.dart';
import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/post_detail_page.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
         return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(posts[index].title,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(posts[index].body,style: TextStyle(fontSize: 16)),
          contentPadding:  EdgeInsets.all(8),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => PostDetailPage(post: posts[index])));
          },
         ); 
      },
      separatorBuilder:(context, index) => Divider(thickness: 1),
      );
  }
}