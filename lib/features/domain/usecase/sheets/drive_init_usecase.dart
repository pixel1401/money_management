import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

class DriveInitUseCase implements UseCase<DriveApi, AuthClient> {
  final SheetsRepository sheetsRepo;
  DriveInitUseCase({required this.sheetsRepo});

  @override
  Future<DriveApi> call(AuthClient params) async {
    return await sheetsRepo.initDrive(params);
  }
}
