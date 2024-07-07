import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class SetDataSheetParams {
  List<RowData> rows;
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetsValueRange;
  
  SetDataSheetParams({ required this.rows , required this.sheetsApi , required this.dataSpread , required this.sheetsValueRange});
}

class SetDataSheetUseCase implements UseCase<PostsData, SetDataSheetParams> {
  final SheetsRepository sheetsRepo;
  SetDataSheetUseCase({required this.sheetsRepo});

  @override
  Future<PostsData> call(SetDataSheetParams params) async {
    return await sheetsRepo.setDataSheet( rows: params.rows , sheetsValueRange: params.sheetsValueRange, dataSpread: params.dataSpread , sheetsApi: params.sheetsApi);
  }
}
