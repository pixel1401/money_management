import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class UpdateDataSheetParams {
  List<RowData> rows;
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetsValueRange;
  int indexPost;
  
  UpdateDataSheetParams({ required this.rows , required this.sheetsApi , required this.dataSpread , required this.indexPost , required this.sheetsValueRange});
}

class UpdateDataSheetUseCase implements UseCase<PostsData, UpdateDataSheetParams> {
  final SheetsRepository sheetsRepo;
  UpdateDataSheetUseCase({required this.sheetsRepo});

  @override
  Future<PostsData> call(UpdateDataSheetParams params) async {
    return await sheetsRepo.updateDataSheet( rows: params.rows , indexPost: params.indexPost, sheetsValueRange: params.sheetsValueRange, dataSpread: params.dataSpread , sheetsApi: params.sheetsApi);
  }
}
