import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class CreateSpreadSheetParams {
  SheetsApi sheetsApi;
  
  CreateSpreadSheetParams(this.sheetsApi);
}

class CreateSpreadSheetUseCase implements UseCase<Spreadsheet, CreateSpreadSheetParams> {
  final SheetsRepository sheetsRepo;
  CreateSpreadSheetUseCase({required this.sheetsRepo});

  @override
  Future<Spreadsheet> call(CreateSpreadSheetParams params) async {
    return await sheetsRepo.createSpreadSheet(params.sheetsApi);
  }
}
