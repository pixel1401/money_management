import 'package:money_management/features/domain/entity/post.dart';

Map<String, List<Post>> dataPostsMock = {
  'Today': mockPosts,
  "Yesterday": mockPosts,
  "20.10.2022": mockPosts
};

List<Post> mockPosts = [
  Post(
    index: 1,
    name: 'Food fowakodp',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Food',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Hello i am oawkd awokd ap',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Food',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
  Post(
    index: 1,
    name: 'Food',
    amount: '100',
    category: 'Food',
    date: '2022-10-10',
    sheetId: 5,
  ),
];