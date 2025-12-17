import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/model/post_model.dart';
import 'package:hive/hive.dart';
class HiveInitializer {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostModelAdapter());
    await Future.wait([
      Hive.openBox<PostModel>('postsBox'),
      Hive.openBox<int>('likesBox'),
    ]);
  }
}

class PostLocalStorage {
  static Box<PostModel> get _box => Hive.box<PostModel>('postsBox');

  static List<PostModel> getAllPosts() {
    return _box.values.toList()
      ..sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
  }

  static Future<void> savePosts(List<PostModel> posts) async {
    final Map<int, PostModel> map = {};

    for (final post in posts) {
      if (post.id != null) {
        map[post.id!] = post;
      }
    }

    await _box.putAll(map);
  }

  /// ✅ ADD THIS
  static bool hasCache() {
    return _box.isNotEmpty;
  }

  static bool isCacheExpired({Duration ttl = const Duration(minutes: 10)}) {
    if (_box.isEmpty) return true;

    final latest = _box.values
        .map((e) => e.cachedAt)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    return DateTime.now().difference(latest) > ttl;
  }

  static void clear() => _box.clear();
}
