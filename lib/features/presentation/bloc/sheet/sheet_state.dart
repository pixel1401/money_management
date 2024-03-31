part of 'sheet_cubit.dart';

abstract class SheetState {}

class SheetValueRange extends ValueRange {
  String? sheetName;
  SheetValueRange({
    String? majorDimension,
    String? range,
    List<List<Object?>>? values,
    required String sheetName
  }) : super(majorDimension: majorDimension , range: range , values: values) {
    this.sheetName = sheetName;
  }
}


class SheetLoading extends SheetState {}
class SheetInitial extends SheetState {}
class SheetSuccess extends SheetState {
  SheetsApi? sheetsApi;
  DriveApi? driveApi;
  Spreadsheet? currentFile;
  String? spreadsheetId;
  List<SheetValueRange>? sheetsValueRange;

  SheetSuccess([this.sheetsApi , this.driveApi , this.currentFile , this.spreadsheetId , this.sheetsValueRange]);

  SheetSuccess copyWith({
    SheetsApi? sheetsApi,
    DriveApi? driveApi,
    Spreadsheet? currentFile,
    String? spreadsheetId,
    List<SheetValueRange>? sheetsValueRange
  }) {
    return SheetSuccess(
      sheetsApi ?? this.sheetsApi,
      driveApi ?? this.driveApi,
      currentFile ?? this.currentFile,
      spreadsheetId ?? this.spreadsheetId,
      sheetsValueRange ?? this.sheetsValueRange
    );
  }
}