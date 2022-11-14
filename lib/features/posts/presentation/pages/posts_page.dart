import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architechture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architechture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:posts_clean_architechture/features/posts/presentation/widgets/posts_page/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text("Posts"));

  Widget _buildBody(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState){
            return LoadingWidget();
          }
          else if (state is LoadedPostState){
            return RefreshIndicator(onRefresh: () => _OnRefresh(context),child: PostsListWidget(posts:state.posts));
          }
          else if (state is ErrorPostsState){
            return MessageDisplayWidget(message:state.message);
          }
          return LoadingWidget();
        },
      ));
  }

Future<void> _OnRefresh(BuildContext context)async {
BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}

  Widget _buildFloatingButton(BuildContext context){
    return FloatingActionButton(onPressed: (() {
      Navigator.push(context, MaterialPageRoute(builder:(_) => PostAddUpdatePage(isUpdate: false)));
    }),
    child: const Icon(Icons.add),
    );
  }
}