import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class GetSpreadSheetParams {
  DriveApi driveApi; 
  SheetsApi sheetsApi;
  
  GetSpreadSheetParams(this.driveApi, this.sheetsApi);
}

class GetSpreadSheetUseCase implements UseCase<Spreadsheet, GetSpreadSheetParams> {
  final SheetsRepository sheetsRepo;
  GetSpreadSheetUseCase({required this.sheetsRepo});

  @override
  Future<Spreadsheet> call(GetSpreadSheetParams params) async {
    return await sheetsRepo.getSpreadSheet(params.driveApi , params.sheetsApi);
  }
}
