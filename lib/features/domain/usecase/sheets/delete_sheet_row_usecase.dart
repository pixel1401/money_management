import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class DeleteSheetRowParams {
  int sheetId, index;
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  
  DeleteSheetRowParams({ required this.sheetId , required this.index , required this.sheetsApi , required this.dataSpread });
}

class DeleteSheetRowUseCase implements UseCase<PostsData, DeleteSheetRowParams> {
  final SheetsRepository sheetsRepo;
  DeleteSheetRowUseCase({required this.sheetsRepo});

  @override
  Future<PostsData> call(DeleteSheetRowParams params) async {
    return await sheetsRepo.deleteSheetRow(index: params.index, sheetId: params.sheetId, dataSpread: params.dataSpread , sheetsApi: params.sheetsApi);
  }
}
