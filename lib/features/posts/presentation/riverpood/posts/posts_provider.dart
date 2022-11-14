import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/posts/posts_notifier.dart';
import '../../../../../injection_container.dart' as di;

final postsProvider = StateNotifierProvider((ref) {
  return di.sl<PostsNotifier>();
});
