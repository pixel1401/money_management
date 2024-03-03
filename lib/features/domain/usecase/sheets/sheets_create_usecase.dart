import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

class SheetsCreate implements UseCase<Spreadsheet, Spreadsheet> {
  final SheetsRepository sheetsRepo;
  SheetsCreate({required this.sheetsRepo});
  
  @override
  Future<Spreadsheet> call(Spreadsheet params) {
    return sheetsRepo.createSheet(params);
  }
}
