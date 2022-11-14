




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts_clean_architechture/features/posts/presentation/riverpood/add_delete_update_post/add_delete_update_notifier.dart';
import '../../../../../injection_container.dart' as di;

final addDeleteUpdatePostProvider = StateNotifierProvider((ref) {
  return di.sl<AddDeleteUpdatePostNotifier>();
});
