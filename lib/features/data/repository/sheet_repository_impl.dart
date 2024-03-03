import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/src/auth_client.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

class SheetRepositoryImpl implements SheetsRepository {
  final SheetsApi client;

  SheetRepositoryImpl(this.client);

  @override
  Future<SheetsApi> initSheet(AuthClient credentials) async {
    var client = sheets.SheetsApi(credentials);
    return client;
  }

  @override
  Future<Spreadsheet> createSheet(Spreadsheet spreadsheet) async {
    return await client.spreadsheets.create(spreadsheet);
  }
}
