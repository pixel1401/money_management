
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

abstract class SheetsRepository {
  Future<SheetsApi> initSheet(AuthClient credentials);
  Future<DriveApi> initDrive(AuthClient credentials);
  // Future<Spreadsheet>createSheet(Spreadsheet spreadsheet);
}