import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/helpers/types.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';



class GetPostsSortDateUsecaseParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetValueRange;
  DateTime? dateStart;
  DateTime? dateEnd;
  TimeRange? timeRange;

  GetPostsSortDateUsecaseParams(
      {required this.sheetsApi,
      required this.dataSpread,
      required this.sheetValueRange,
      DateTime? dateStart,
      DateTime? dateEnd,
      TimeRange? timeRange});
}


class GetPostsSortDateUsecase implements UseCase<PostsData?, GetPostsSortDateUsecaseParams> {
  final SheetsRepository sheetsRepo;
  GetPostsSortDateUsecase({required this.sheetsRepo});

  @override
  Future<PostsData> call(GetPostsSortDateUsecaseParams params) async {
    return await sheetsRepo.getPostsSortDate(
        dataSpread: params.dataSpread,
        sheetValueRange: params.sheetValueRange,
        sheetsApi: params.sheetsApi,
        dateStart: params.dateStart,
        dateEnd: params.dateEnd,
        timeRange: params.timeRange
    );
  }
}

