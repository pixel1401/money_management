import 'dart:core';

import 'package:googleapis/sheets/v4.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';

import '../../../../core/helpers/types.dart';

class GetPostsParams {
  Spreadsheet dataSpread;
  SheetsApi sheetsApi;
  List<SheetValueRange> sheetValueRange;
  DateTime? dateStart;
  DateTime? dateEnd;
  TimeRange? timeRange;

  GetPostsParams(
      {required this.sheetsApi,
      required this.dataSpread,
      required this.sheetValueRange,
      DateTime? dateStart,
      DateTime? dateEnd,
      TimeRange? timeRange});
}

class GetPostsUseCase implements UseCase<List<Post>, GetPostsParams> {
  final SheetsRepository sheetsRepo;
  GetPostsUseCase({required this.sheetsRepo});

  @override
  Future<List<Post>> call(GetPostsParams params) async {
    return await sheetsRepo.getPosts(
        dataSpread: params.dataSpread,
        sheetValueRange: params.sheetValueRange,
        sheetsApi: params.sheetsApi,
        dateStart: params.dateStart,
        dateEnd: params.dateEnd,
        timeRange: params.timeRange);
  }
}
