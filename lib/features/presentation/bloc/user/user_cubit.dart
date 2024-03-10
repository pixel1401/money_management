import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/features/domain/usecase/user_authenticated_client_usecase.dart';
import 'package:money_management/features/domain/usecase/user_sign_in_usecase.dart';
import 'package:money_management/features/presentation/bloc/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserSignIn userSignInUseCase;
  final UserAuthenticatedClient userAuthenticatedClient;

  UserCubit(this.userSignInUseCase , this.userAuthenticatedClient) : super(UserStateLoading());

  void getUserData() async {
    var data = await userSignInUseCase({});
    var authClient = await initCredentials();
    if (data != null && authClient != null) {
      emit(Authorized(data , authClient));
    } else {
      emit(UnAuthorizedState());
    }
  }


  initCredentials  () async {
    var data = await userAuthenticatedClient({});
    if(data != null) {
      return data;
    }

  }
}
