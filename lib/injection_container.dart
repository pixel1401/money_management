import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:money_management/features/data/repository/user_repository_impl.dart';
import 'package:money_management/features/domain/repository/user_repository.dart';
import 'package:money_management/features/domain/usecase/user_authenticated_client_usecase.dart';
import 'package:money_management/features/domain/usecase/user_is_auth_usecase.dart';
import 'package:money_management/features/domain/usecase/user_sign_in_usecase.dart';
import 'package:money_management/features/domain/usecase/user_sign_out_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // GOOGLE_SIGN_IN_OPTIONS
  sl.registerSingleton(GoogleSignIn(
    clientId:
        '484095062673-bubg4k1m93h9n0va5q3299rd0ol33kto.apps.googleusercontent.com',
    scopes: [
      drive.DriveApi.driveScriptsScope,
      sheets.SheetsApi.spreadsheetsScope
    ],
  ));

  // USE CASE
  sl.registerLazySingleton(() => UserSignIn(userRepository: sl()));
  sl.registerLazySingleton(() => UserSignOut(userRepository: sl()));
  sl.registerLazySingleton(() => UserAuthenticatedClient(userRepository: sl()));
  sl.registerLazySingleton(() => UserIsAuth(userRepository: sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(google: sl()));
}
