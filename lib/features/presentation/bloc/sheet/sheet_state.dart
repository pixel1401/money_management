

import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart' as drive;

abstract class SheetState {}

class SheetLoading extends SheetState {}
class SheetInitial extends SheetState {}
class SheetSuccess extends SheetState {
  SheetsApi? sheetsApi;
  DriveApi? driveApi;
  Spreadsheet? currentFile;

  SheetSuccess([this.sheetsApi , this.driveApi , this.currentFile]);

  SheetSuccess copyWith({
    SheetsApi? sheetsApi,
    DriveApi? driveApi,
    Spreadsheet? currentFile
  }) {
    return SheetSuccess(
      sheetsApi ?? this.sheetsApi,
      driveApi ?? this.driveApi,
      currentFile ?? this.currentFile
    );
  }
}