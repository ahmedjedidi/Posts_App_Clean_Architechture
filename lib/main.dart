import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architechture/core/app_theme.dart';
import 'package:posts_clean_architechture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/posts_page.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'injection_container.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          theme: appTheme,
          home: PostsPage(),
        ));
  }
}

