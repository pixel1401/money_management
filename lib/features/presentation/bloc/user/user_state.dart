import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

abstract class UserState {}


class UserStateLoading extends UserState {}

class UnAuthorizedState extends UserState {}

class Authorized extends UserState {
  final GoogleSignInAccount userData;
  final AuthClient? authClient;

  Authorized(this.userData , this.authClient);
}