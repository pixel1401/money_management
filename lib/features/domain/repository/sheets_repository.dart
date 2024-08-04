import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/core/helpers/types.dart';

import '../entity/post.dart';

abstract class SheetsRepository {
  Future<SheetsApi> initSheet(AuthClient credentials);
  Future<DriveApi> initDrive(AuthClient credentials);

  Future<Spreadsheet> getSpreadSheet(DriveApi driveApi, SheetsApi sheetsApi);
  Future<Spreadsheet> createSpreadSheet(SheetsApi sheetsApi);

  Future<List<SheetValueRange>> getSheets(
      SheetsApi sheetsApi, Spreadsheet dataSpread);
  Future<List<String>> getCategories(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetValueRange});


  Future<bool> clearEmptySheetRowsValue(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetsValueRange});
  Future<PostsData> deleteSheetRow(
      {required int sheetId,
      required int index,
      required SheetsApi sheetsApi,
      required Spreadsheet dataSpread});

  Future<PostsData> setDataSheet(
      {required List<RowData> rows,
      required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetsValueRange});
    
  Future<PostsData> updateDataSheet(
      {required List<RowData> rows,
      required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required int indexPost,
      required List<SheetValueRange> sheetsValueRange});


  Future<num> getTotalPriceSheet(
      {required SheetsApi sheetsApi,
      required Spreadsheet dataSpread,
      required List<SheetValueRange> sheetsValueRange,
      required String sheetName,
      DateTime? dateStart,
      DateTime? dateEnd,
      TimeRange? timeRange});

  

  Future<PostsData> getPostsSortDate ({
    required SheetsApi sheetsApi,
    required Spreadsheet dataSpread,
    required List<SheetValueRange> sheetValueRange,
    int? sheetId,
    int currentPage = 1,
    int pageSize = 10,
    DateTime? dateStart,
    DateTime? dateEnd,
    TimeRange? timeRange
  });


  Future<List<PieChartVM>> getPieChartData( {
    required SheetsApi sheetsApi,
    required Spreadsheet dataSpread,
    required String sheetName,
  });
}
