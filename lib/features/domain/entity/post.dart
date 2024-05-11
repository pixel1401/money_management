import 'package:googleapis/sheets/v4.dart';

class SheetValueRange extends ValueRange {
  String? sheetName ;
  int? sheetId;
  SheetValueRange({
    super.majorDimension,
    super.range,
    super.values,
    required String this.sheetName,
    required int this.sheetId
  });
}



class Post {
  String category, name, date, amount ;
  int index , sheetId;
  Post({required this.index , required this.sheetId, required this.category , required this.name  , required this.date , required this.amount });
}