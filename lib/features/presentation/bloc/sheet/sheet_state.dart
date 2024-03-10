

import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart' as drive;

abstract class SheetState {}

class SheetLoading extends SheetState {}
class SheetInitial extends SheetState {}
class SheetSuccess extends SheetState {
  SheetsApi? sheetsApi;
  DriveApi? driveApi;

  SheetSuccess([this.sheetsApi , this.driveApi]);

  SheetSuccess copyWith({
    SheetsApi? sheetsApi,
    DriveApi? driveApi
  }) {
    return SheetSuccess(
      sheetsApi ?? this.sheetsApi,
      driveApi ?? this.driveApi
    );
  }
}