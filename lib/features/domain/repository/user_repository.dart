import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/features/data/model/user.dart';

abstract class UserRepository {
  Future<GoogleSignInAccount?> userSignIn();
  Future<GoogleSignInAccount?> userSignOut();

  Future<bool> userIsAuth();
  Future<User> userGet();

  Future<AuthClient?> authenticatedClient();
}
