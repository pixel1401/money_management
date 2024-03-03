import 'package:google_sign_in/google_sign_in.dart';

abstract class UserState {}


class UserStateLoading extends UserState {}

class UnAuthorizedState extends UserState {}

class Authorized extends UserState {
  final GoogleSignInAccount userData;

  Authorized(this.userData);
}