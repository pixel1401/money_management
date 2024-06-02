import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/helpers/types.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

class GetTotalPriceSheetUsecaseParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetsValueRange;
  String sheetName;
  DateTime? dateStart;
  DateTime? dateEnd;
  TimeRange? timeRange;

  GetTotalPriceSheetUsecaseParams(
      {required this.sheetsApi,
      required this.dataSpread,
      required this.sheetsValueRange,
      required this.sheetName,
      DateTime? dateStart,
      DateTime? dateEnd,
      TimeRange? timeRange});
}

class GetTotalPriceSheetUsecase implements UseCase<num, GetTotalPriceSheetUsecaseParams> {
  final SheetsRepository sheetsRepo;
  GetTotalPriceSheetUsecase({required this.sheetsRepo});

  @override
  Future<num> call(GetTotalPriceSheetUsecaseParams params) async {
    return await sheetsRepo.getTotalPriceSheet(
        sheetsApi: params.sheetsApi,
        dataSpread: params.dataSpread,
        sheetsValueRange: params.sheetsValueRange,
        sheetName: params.sheetName,
        dateEnd: params.dateEnd,
        dateStart: params.dateStart,
        timeRange: params.timeRange);
  }
}
