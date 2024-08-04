import 'package:equatable/equatable.dart';
import 'package:googleapis/sheets/v4.dart';

class SheetValueRange extends ValueRange {
  String? sheetName;
  int? sheetId;
  SheetValueRange(
      {super.majorDimension,
      super.range,
      super.values,
      required String this.sheetName,
      required int this.sheetId});
}

class Post extends Equatable {
  String date;
  String category, name, amount;
  String? color;
  int index, sheetId;
  Post(
      {required this.index,
      required this.sheetId,
      required this.category,
      required this.name,
      required this.date,
      required this.amount,
      this.color,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        index,
        sheetId,
        category,
        name,
        date,
        amount,
        color
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

class PostsData {
  List<Post> posts;
  int total;
  int current;
  PostsData({required this.posts, required this.total, required this.current});
}

class PieChartVM {
  num percent;
  String title;

  PieChartVM({required this.percent, required this.title});
}
