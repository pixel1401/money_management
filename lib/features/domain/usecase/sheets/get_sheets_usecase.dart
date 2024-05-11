import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class GetSheetsParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  
  GetSheetsParams(this.sheetsApi , this.dataSpread );
}

class GetSheetsUseCase implements UseCase<List<SheetValueRange>, GetSheetsParams> {
  final SheetsRepository sheetsRepo;
  GetSheetsUseCase({required this.sheetsRepo});

  @override
  Future<List<SheetValueRange>> call(GetSheetsParams params) async {
    return await sheetsRepo.getSheets(params.sheetsApi , params.dataSpread);
  }
}
