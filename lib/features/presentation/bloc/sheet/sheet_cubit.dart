import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/features/domain/usecase/sheets/drive_init_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/sheets_init_usecase.dart';

part 'sheet_state.dart';

const APP_FILE_NAME = 'Money_Management';
const QUERY_FILE = 'name="Money_Management" and trashed = false';

class SheetCubit extends Cubit<SheetState> {
  // AuthClient credentials;
  SheetsInit sheetInitUseCase;
  DriveInitUseCase driveInitUseCase;

  SheetCubit(this.sheetInitUseCase, this.driveInitUseCase)
      : super(SheetLoading());

  void initSheet(AuthClient credentials) async {
    try {
      var sheetData = await sheetInitUseCase.call(credentials);
      emit(SheetSuccess(sheetData));

      var driveData = await driveInitUseCase.call(credentials);
      var currentState = state;
      if (currentState is SheetSuccess) {
        var newState = currentState.copyWith(driveApi: driveData);
        emit(newState);
      }

      if (state is SheetSuccess) {
        await getSpreadSheet();
        await getDataSpreadSheet();
      }
    } catch (e) {
      throw ('ERROR INIT APIES', e);
    }
  }

  Future<void> getSpreadSheet() async {
    var spreadsheet = Spreadsheet();
    spreadsheet.properties = SpreadsheetProperties(title: APP_FILE_NAME);
    spreadsheet.sheets = [
      Sheet(properties: SheetProperties(title: DateTime.now().year.toString()))
    ];

    var currentState = state;

    if (currentState is SheetSuccess &&
        currentState.driveApi != null &&
        currentState.sheetsApi != null) {
      var datafileList = await currentState.driveApi!.files.list(q: QUERY_FILE);

      Spreadsheet? dataSpread;

      if (datafileList.files != null && datafileList.files!.length > 0) {
        var getSpreadSheet = await currentState.sheetsApi!.spreadsheets
            .get(datafileList.files?.first.id ?? '');

        dataSpread = getSpreadSheet;
      } else {
        var createSpreadSheet =
            await currentState.sheetsApi!.spreadsheets.create(spreadsheet);
        dataSpread = createSpreadSheet;
      }

      if (dataSpread != null) {
        emit(currentState.copyWith(
            currentFile: dataSpread, spreadsheetId: dataSpread.spreadsheetId));
      }
    }
  }

  Future<void> getDataSpreadSheet() async {
    var currentState = state;
    List<SheetValueRange> dataValueRange = [];
    if (currentState is SheetSuccess) {
      List<String> sheetNames = [];
      if (currentState.currentFile?.sheets != null) {
        for (var a in currentState.currentFile!.sheets!) {
          if (a.properties?.title != null) {
            sheetNames.add(a.properties!.title!);
          }
        }
      }

      for (var a in sheetNames) {
        var data = await currentState.sheetsApi!.spreadsheets.values
            .get(currentState.spreadsheetId ?? '', a + '!A:D');
        dataValueRange.add(SheetValueRange(
            sheetName: a,
            majorDimension: data.majorDimension,
            values: data.values));
      }

      if (dataValueRange.length > 0) {
        emit(currentState.copyWith(sheetsValueRange: dataValueRange));
      }
    }
  }

  Future<void> clearEmptySheetRowsValue() async {
    var currentState = state;
    if (currentState is! SheetSuccess) return;

    var currentStateSuccess = currentState as SheetSuccess;
    if (currentStateSuccess.sheetsValueRange == null) return;

    List<Request>? requestsForDelete = [];

    for (var a in currentStateSuccess.sheetsValueRange!) {
      int rowIndexLast = a.values?.length ?? 0;
      int indexList = currentStateSuccess.sheetsValueRange!.indexOf(a);
      if (a.values == null) continue;

      for (var i = 0; i < a.values!.length; i++) {
        var valueItem = a.values![i];

        if (valueItem == null) continue;
        if (valueItem.length < 4) {
          var itemProperties =
              currentState.currentFile?.sheets?[indexList].properties;
          if (itemProperties?.title != a.sheetName) break;
          requestsForDelete.add(Request(
              deleteDimension: DeleteDimensionRequest(
                  range: DimensionRange(
                      sheetId: itemProperties?.sheetId,
                      dimension: "ROWS",
                      startIndex: i,
                      endIndex: i + 1))));
        }
      }
    }

    if (requestsForDelete.length > 0) {
      BatchUpdateSpreadsheetRequest request =
          BatchUpdateSpreadsheetRequest(requests: requestsForDelete);
      await currentStateSuccess.sheetsApi!.spreadsheets.batchUpdate(
        request,
        currentStateSuccess.spreadsheetId ?? '',
      );
    }
  }

  Future<void> deleteSheetRow({required int sheetId, required int index}) async {
    var currentState = state;
    if (currentState is! SheetSuccess) return;

    Request requestsForDelete = Request(
        deleteDimension: DeleteDimensionRequest(
            range: DimensionRange(
                sheetId: sheetId,
                dimension: "ROWS",
                startIndex: index,
                endIndex: index + 1)));

    BatchUpdateSpreadsheetRequest request =
        BatchUpdateSpreadsheetRequest(requests: [requestsForDelete]);
    await currentState.sheetsApi!.spreadsheets.batchUpdate(
      request,
      currentState.spreadsheetId ?? '',
    );
  }

  Future<void> pushDataSpreadSheet({required List<RowData> rows}) async {
    if (state is! SheetSuccess) return;

    var currentState = state as SheetSuccess;
    if (currentState.sheetsValueRange == null) return;

    for (var a in currentState.sheetsValueRange!) {
      if (a.sheetName == DateTime.now().year.toString()) {
        int rowIndexLast = a.values?.length ?? 0;

        BatchUpdateSpreadsheetRequest request =
            BatchUpdateSpreadsheetRequest(requests: [
          Request(
              updateCells: UpdateCellsRequest(
            fields: "*",
            start: GridCoordinate(
                columnIndex: 0,
                rowIndex: rowIndexLast,
                sheetId:
                    currentState.currentFile!.sheets?[0].properties?.sheetId),
            rows: rows,
          ))
        ]);

        var res = await currentState.sheetsApi!.spreadsheets
            .batchUpdate(request, currentState.spreadsheetId!, $fields: "*");
        emit(currentState.copyWith(
            currentFile: res.updatedSpreadsheet,
            spreadsheetId: res.spreadsheetId));
        await getDataSpreadSheet();
        await clearEmptySheetRowsValue();
      }
    }
  }
}
