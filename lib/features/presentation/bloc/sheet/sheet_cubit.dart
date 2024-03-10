import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/features/domain/usecase/sheets/drive_init_usecase.dart';
import 'package:money_management/features/domain/usecase/sheets/sheets_init_usecase.dart';
import 'package:money_management/features/presentation/bloc/sheet/sheet_state.dart';
import 'package:money_management/features/presentation/bloc/user/user_cubit.dart';

class SheetCubit extends Cubit<SheetState> {
  // AuthClient credentials;
  SheetsInit sheetInitUseCase;
  DriveInitUseCase driveInitUseCase;

  SheetCubit(this.sheetInitUseCase , this.driveInitUseCase) : super(SheetLoading());

  void initSheet(AuthClient credentials) {
    // print('CREDENT :: ');

    // var cubitA = BlocProvider.of<UserCubit>();
    sheetInitUseCase.call(credentials).then((value) {
      emit(SheetSuccess(value));
    }).catchError((err) => {print(err)});

    driveInitUseCase.call(credentials).then((value) {
      var currentState = state;
      if(currentState is SheetSuccess){
        var newState = currentState.copyWith(driveApi: value );
        emit(newState);
      }
    }).catchError((err) => {
      print(err)
    });
  }
}
