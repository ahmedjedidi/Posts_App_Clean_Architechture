import 'package:posts_clean_architechture/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/post_detail_page.dart/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text("Post Detail"));

  Widget _buildBody(){
   return Center(child: Padding(
    padding: EdgeInsets.all(10),
   child:PostDetailWidget(post:post)
   ));
  }
}