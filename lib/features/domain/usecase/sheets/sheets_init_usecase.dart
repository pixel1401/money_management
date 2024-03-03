import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

class SheetsInit implements UseCase<SheetsApi, AuthClient> {
  final SheetsRepository sheetsRepo;
  SheetsInit({required this.sheetsRepo});
  
  @override
  Future<SheetsApi> call(AuthClient params) {
    return sheetsRepo.initSheet(params);
  }
}
