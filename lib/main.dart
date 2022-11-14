import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/core/app_theme.dart';
import 'package:posts_clean_architechture/features/posts/presentation/pages/posts_page.dart';
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
    return ProviderScope(child: 
         MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          theme: appTheme,
          home: PostsPage(),
        ));
  }
}

