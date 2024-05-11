
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import '../entity/post.dart';

abstract class SheetsRepository {
  Future<SheetsApi> initSheet(AuthClient credentials);
  Future<DriveApi> initDrive(AuthClient credentials);

  Future<Spreadsheet> getSpreadSheet(DriveApi driveApi , SheetsApi sheetsApi);
  Future<Spreadsheet> createSpreadSheet(SheetsApi sheetsApi);  

  Future<List<SheetValueRange>> getSheets(SheetsApi sheetsApi , Spreadsheet dataSpread);
  Future<List<String>> getCategories({required SheetsApi sheetsApi , required Spreadsheet dataSpread , required List<SheetValueRange> sheetValueRange});

  Future<List<Post>> getPosts({required SheetsApi sheetsApi , required Spreadsheet dataSpread , required List<SheetValueRange> sheetValueRange});

  Future<bool> clearEmptySheetRowsValue({required SheetsApi sheetsApi , required Spreadsheet dataSpread , required List<SheetValueRange> sheetsValueRange});
  Future<void> deleteSheetRow({required int sheetId, required int index , required SheetsApi sheetsApi , required Spreadsheet dataSpread});

  Future<void> setDataSheet({required List<RowData> rows , required SheetsApi sheetsApi , required Spreadsheet dataSpread , required List<SheetValueRange> sheetsValueRange});
}