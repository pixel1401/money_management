import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class ClearEmptySheetRowsValueParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetsValueRange;
  
  ClearEmptySheetRowsValueParams({required this.sheetsApi , required this.dataSpread , required this.sheetsValueRange});
}

class ClearEmptySheetRowsValueUseCase implements UseCase<bool, ClearEmptySheetRowsValueParams> {
  final SheetsRepository sheetsRepo;
  ClearEmptySheetRowsValueUseCase({required this.sheetsRepo});

  @override
  Future<bool> call(ClearEmptySheetRowsValueParams params) async {
    return await sheetsRepo.clearEmptySheetRowsValue(sheetsValueRange: params.sheetsValueRange, dataSpread: params.dataSpread , sheetsApi: params.sheetsApi);
  }
}
