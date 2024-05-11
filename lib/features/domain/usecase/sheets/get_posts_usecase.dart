import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';


class GetPostsParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetValueRange;
  
  GetPostsParams({required this.sheetsApi , required this.dataSpread , required this.sheetValueRange});
}

class GetPostsUseCase implements UseCase<List<Post>, GetPostsParams> {
  final SheetsRepository sheetsRepo;
  GetPostsUseCase({required this.sheetsRepo});

  @override
  Future<List<Post>> call(GetPostsParams params) async {
    return await sheetsRepo.getPosts(dataSpread: params.dataSpread , sheetValueRange: params.sheetValueRange, sheetsApi: params.sheetsApi);
  }
}
