import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/domain/usecase/sheets/clear_empty_sheet_row_value_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/create_spreadsheet_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/delete_sheet_row_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/drive_init_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_categories_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_posts_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_sheets_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_spreadsheet_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/set_data_sheet_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/sheets_init_usecase.dart';

part 'sheet_state.dart';

class SheetCubit extends Cubit<SheetState> {
  // AuthClient credentials;
  SheetsInit sheetInitUseCase;
  DriveInitUseCase driveInitUseCase;
  GetSpreadSheetUseCase getSpreadSheetUseCase;
  CreateSpreadSheetUseCase createSpreadSheetUseCase;
  GetSheetsUseCase getSheetsUseCase;
  GetCategoriesUseCase getCategoriesUseCase;
  GetPostsUseCase getPostsUseCase;
  ClearEmptySheetRowsValueUseCase clearEmptySheetRowsValueUseCase;
  DeleteSheetRowUseCase deleteSheetRowUseCase;
  SetDataSheetUseCase setDataSheetUseCase;

  SheetCubit(
      this.sheetInitUseCase,
      this.driveInitUseCase,
      this.getSpreadSheetUseCase,
      this.createSpreadSheetUseCase,
      this.getSheetsUseCase,
      this.getCategoriesUseCase,
      this.getPostsUseCase,
      this.clearEmptySheetRowsValueUseCase,
      this.deleteSheetRowUseCase,
      this.setDataSheetUseCase)
      : super(SheetState(isLoading: true, isError: false));

  void initSheet(AuthClient credentials) async {
    try {
      // emit(state.startResponse(true));
      var sheetData = await sheetInitUseCase.call(credentials);
      emit(state.copyWith(sheetsApi: sheetData));

      var driveData = await driveInitUseCase.call(credentials);
      emit(state.copyWith(driveApi: driveData));

      await getSpreadSheet();
      await getSheets();
      await getCategories();
      await getPosts();

      emit(state.startResponse(false));
    } catch (e) {
      throw ('ERROR INIT APIES', e);
    }
  }

  Future<void> getCategories() async {
    var categories = await getCategoriesUseCase.call(GetCategoriesParams(
        sheetsApi: state.sheetsApi!,
        dataSpread: state.spreadsheet!,
        sheetValueRange: state.sheetsValueRange!));
    emit(state.copyWith(categories: categories));
  }

  Future<void> getSheets() async {
    var sheets = await getSheetsUseCase
        .call(GetSheetsParams(state.sheetsApi!, state.spreadsheet!));
    emit(state.copyWith(sheetsValueRange: sheets));
  }

  Future<void> getPosts() async {
    var posts = await getPostsUseCase.call(GetPostsParams(
      sheetsApi: state.sheetsApi!,
      dataSpread: state.spreadsheet!,
      sheetValueRange: state.sheetsValueRange!,
    ));
    emit(state.copyWith(posts: posts));
  }

  //? Получение spreadsheet / если нет создание
  Future<void> getSpreadSheet() async {
    if (state.sheetsApi == null || state.driveApi == null) return;

    var spreadsheet = await getSpreadSheetUseCase
        .call(GetSpreadSheetParams(state.driveApi!, state.sheetsApi!));

    if (spreadsheet == null) {
      var createSpreadSheet = await createSpreadSheetUseCase
          .call(CreateSpreadSheetParams(state.sheetsApi!));
      emit(state.copyWith(spreadsheet: createSpreadSheet));
    } else {
      emit(state.copyWith(spreadsheet: spreadsheet));
    }
  }

  Future<void> clearEmptySheetRowsValue() async {
    await clearEmptySheetRowsValueUseCase.call(ClearEmptySheetRowsValueParams(
      sheetsApi: state.sheetsApi!,
      dataSpread: state.spreadsheet!,
      sheetsValueRange: state.sheetsValueRange!,
    ));
    await getSheets();
  }

  Future<void> deleteSheetRow(
      {required int sheetId, required int index}) async {
    emit(state.startResponse(true));
    await deleteSheetRowUseCase.call(DeleteSheetRowParams(
      sheetId: sheetId,
      index: index,
      sheetsApi: state.sheetsApi!,
      dataSpread: state.spreadsheet!,
    ));
    await getSheets();
    await getCategories();
    await getPosts();
    emit(state.startResponse(false));
  }

  Future<void> pushDataSpreadSheet({required List<RowData> rows}) async {
    emit(state.startResponse(true));
    var data = await setDataSheetUseCase.call(SetDataSheetParams(
      rows: rows,
      sheetsApi: state.sheetsApi!,
      dataSpread: state.spreadsheet!,
      sheetsValueRange: state.sheetsValueRange!,
    ));

    await getSheets();
    await clearEmptySheetRowsValue();
    await getCategories();
    await getPosts();
    emit(state.startResponse(false));
  }
}
