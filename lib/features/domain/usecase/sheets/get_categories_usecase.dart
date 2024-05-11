import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class GetCategoriesParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetValueRange;
  
  GetCategoriesParams({required this.sheetsApi , required this.dataSpread , required this.sheetValueRange});
}

class GetCategoriesUseCase implements UseCase<List<String>, GetCategoriesParams> {
  final SheetsRepository sheetsRepo;
  GetCategoriesUseCase({required this.sheetsRepo});

  @override
  Future<List<String>> call(GetCategoriesParams params) async {
    return await sheetsRepo.getCategories(dataSpread: params.dataSpread , sheetValueRange: params.sheetValueRange, sheetsApi: params.sheetsApi);
  }
}
