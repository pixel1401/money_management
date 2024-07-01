part of 'sheet_cubit.dart';



class SheetState{
  SheetsApi? sheetsApi;
  DriveApi? driveApi;
  Spreadsheet? spreadsheet;
  String? spreadsheetId;
  List<SheetValueRange>? sheetsValueRange;
  List<String>? categories;
  
  List<Post>? posts;
  Map<String , List<Post>>? dataPosts;

  List<PieChartVM>? pieChartData;

  num? totalPrice;
  List<Post>? periodPost;



  // STATE_RESPONSE
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
      this.posts,
      this.totalPrice,
      this.pieChartData,
      this.dataPosts
    });

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
      num? totalPrice,
      List<PieChartVM>? pieChartData,
      Map<String , List<Post>>? dataPosts
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
        posts: posts ?? this.posts,
        totalPrice: totalPrice ?? this.totalPrice,
        pieChartData: pieChartData ?? this.pieChartData,
        dataPosts: dataPosts ?? this.dataPosts
        );
  }


  SheetState startResponse (bool value) {
    if(value) {
      return copyWith(isError: false, isLoading: true);
    }else {
      return copyWith(isError: false , isLoading: false);
    }
  }
}

