import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/features/domain/usecase/user_sign_in_usecase.dart';
import 'package:money_management/features/presentation/bloc/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserSignIn userSignInUseCase;

  UserCubit(this.userSignInUseCase) : super(UserStateLoading());

  void getUserData() async {
    var data = await userSignInUseCase({});
    if (data != null) {
      emit(Authorized(data));
    } else {
      emit(UnAuthorizedState());
    }
  }
}
