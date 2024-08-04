import 'package:intl/intl.dart';
import 'package:money_management/core/helpers/helpers.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:test/test.dart';

import 'mock/post_mock.dart';

void main() {
  group('calculateSum_group', () {
    test('calculateSum', () {
      final counter = calculateSum(['1', '2', '3']);

      expect(counter, 6);
    });

    test('calculateSum 2', () {
      final counter = calculateSum(['1.5', '2', '3']);

      expect(counter, 6.5);
    });
  });

  group('getMapData', () {
    late PostsData posts;
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setUp(() async {
      posts = PostsData(current: 1, total: 10, posts: mockPosts);
    });

    test('formate Post', () {
      var data = getMapData(posts);

      expect(data, {'10.10.2022': mockPosts});
    });

    test('current day Posts', () {
      var currentPost = Post(
          index: 899,
          sheetId: 894846,
          category: '12d',
          name: 'awd21',
          date: today,
          amount: '12');
      var postsCurrentDay = PostsData(
          posts: [...posts.posts, currentPost],
          total: posts.total,
          current: posts.current);

      var data = getMapData(postsCurrentDay);

      expect(data, {
        '10.10.2022': mockPosts,
        "Сегодня": [currentPost]
      });
    });
  });
}
