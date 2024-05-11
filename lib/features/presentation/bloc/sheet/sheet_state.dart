part of 'sheet_cubit.dart';



class SheetState{
  SheetsApi? sheetsApi;
  DriveApi? driveApi;
  Spreadsheet? spreadsheet;
  String? spreadsheetId;
  List<SheetValueRange>? sheetsValueRange;
  List<String>? categories;
  List<Post>? posts;

  bool isLoading = false;
  bool isError = false;

  SheetState(
      {this.isLoading = false,
      this.isError = false,
      this.sheetsApi,
      this.driveApi,
      this.spreadsheet,
      this.spreadsheetId,
      this.sheetsValueRange,
      this.categories,
      this.posts});

  SheetState copyWith(
      {bool? isLoading,
      bool? isError,
      SheetsApi? sheetsApi,
      DriveApi? driveApi,
      Spreadsheet? spreadsheet,
      String? spreadsheetId,
      List<SheetValueRange>? sheetsValueRange,
      List<String>? categories,
      List<Post>? posts,
      }) {
    return SheetState(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        sheetsApi: sheetsApi ?? this.sheetsApi,
        driveApi: driveApi ?? this.driveApi,
        spreadsheet: spreadsheet ?? this.spreadsheet,
        spreadsheetId: spreadsheetId ?? this.spreadsheetId,
        sheetsValueRange: sheetsValueRange ?? this.sheetsValueRange,
        categories: categories ?? this.categories,
        posts: posts ?? this.posts);
  }


  SheetState startResponse (bool value) {
    if(value) {
      return copyWith(isError: false, isLoading: true);
    }else {
      return copyWith(isError: false , isLoading: false);
    }
  }
}

