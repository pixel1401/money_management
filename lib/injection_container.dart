import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:money_management/features/data/repository/sheet_repository_impl.dart';
import 'package:money_management/features/data/repository/user_repository_impl.dart';
import 'package:money_management/features/domain/repository/sheets_repository.dart';
import 'package:money_management/features/domain/repository/user_repository.dart';
import 'package:money_management/features/domain/usecase/sheets/clear_empty_sheet_row_value_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/create_spreadsheet_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/delete_sheet_row_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/drive_init_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_categories_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_posts_sort_date_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_sheets_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/get_spreadsheet_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/set_data_sheet_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/sheets_init_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/update_data_sheet_usecase.dart';
import 'package:money_management/features/domain/usecase/user_authenticated_client_usecase.dart';
import 'package:money_management/features/domain/usecase/user_is_auth_usecase.dart';
import 'package:money_management/features/domain/usecase/user_sign_in_usecase.dart';
import 'package:money_management/features/domain/usecase/user_sign_out_usecase.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_cubit.dart';
import 'package:money_management/features/presentation/bloc/user/user_cubit.dart';

import 'features/domain/usecase/sheets/get_pie_chart_usecase.dart';
import 'features/domain/usecase/sheets/get_total_price_sheet_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // GOOGLE_SIGN_IN_OPTIONS
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn(
    clientId:
        '484095062673-bubg4k1m93h9n0va5q3299rd0ol33kto.apps.googleusercontent.com',
    scopes: [
      drive.DriveApi.driveScriptsScope,
      drive.DriveApi.driveScope,
      sheets.SheetsApi.spreadsheetsScope
    ],
  ));

  // USE CASE
  sl.registerLazySingleton<UserSignIn>(() => UserSignIn(userRepository: sl()));
  sl.registerLazySingleton(() => UserSignOut(userRepository: sl()));
  sl.registerLazySingleton<UserAuthenticatedClient>(
      () => UserAuthenticatedClient(userRepository: sl()));
  sl.registerLazySingleton(() => UserIsAuth(userRepository: sl()));

  //? SHEET
  sl.registerLazySingleton(() => SheetsInit(sheetsRepo: sl()));
  sl.registerLazySingleton(() => DriveInitUseCase(sheetsRepo: sl()));

  sl.registerLazySingleton(() => GetSpreadSheetUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(() => CreateSpreadSheetUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(() => GetSheetsUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(
      () => ClearEmptySheetRowsValueUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(() => DeleteSheetRowUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(() => SetDataSheetUseCase(sheetsRepo: sl()));
  sl.registerLazySingleton(() => UpdateDataSheetUseCase(sheetsRepo: sl()));
  sl.registerFactory(() => GetPostsSortDateUsecase(sheetsRepo: sl()));
  sl.registerFactory(() => GetTotalPriceSheetUsecase(sheetsRepo: sl()));

  sl.registerFactory(() => GetPieChartUseCase(sheetsRepo: sl()));
  
  // USE CASE END

  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(google: sl()));

  sl.registerLazySingleton<SheetsRepository>(() => SheetRepositoryImpl());

  // BLOC
  sl.registerFactory<UserCubit>(() => UserCubit(sl(), sl()));

  sl.registerFactory(() => SheetCubit(
        sheetInitUseCase: sl(),
        driveInitUseCase: sl(),
        getSpreadSheetUseCase: sl(),
        clearEmptySheetRowsValueUseCase: sl(),
        deleteSheetRowUseCase: sl(),
        getCategoriesUseCase: sl(),
        createSpreadSheetUseCase: sl(),
        updateDataSheetUseCase: sl(),
        getSheetsUseCase: sl(),
        setDataSheetUseCase: sl(),
        getPostsSortDateUsecase: sl(),
        getTotalPriceSheetUsecase: sl(),
        getPieChartUseCase: sl(),
      ));

  // sl.registerFactory<SheetCubit>(() =>
  //     SheetCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
}
