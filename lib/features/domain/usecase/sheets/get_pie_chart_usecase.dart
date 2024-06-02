import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class GetPieChartUseCaseParams {
  SheetsApi sheetsApi;
  Spreadsheet dataSpread;
  String sheetName;
  
  GetPieChartUseCaseParams({required this.sheetsApi, required this.dataSpread, required this.sheetName});
}

class GetPieChartUseCase implements UseCase<List<PieChartVM>, GetPieChartUseCaseParams> {
  final SheetsRepository sheetsRepo;
  GetPieChartUseCase({required this.sheetsRepo});

  @override
  Future<List<PieChartVM>> call(GetPieChartUseCaseParams params) async {
    return await sheetsRepo.getPieChartData(
        sheetsApi: params.sheetsApi,
        dataSpread: params.dataSpread,
        sheetName: params.sheetName
    );
  }

}