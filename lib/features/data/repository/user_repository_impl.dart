import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/src/auth_client.dart';
import 'package:money_management/features/data/model/user.dart';
import 'package:money_management/features/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final GoogleSignIn google;

  UserRepositoryImpl({required this.google});

  @override
  Future<AuthClient?> authenticatedClient() async {
    return await google.authenticatedClient();
  }

  @override
  Future<User> userGet() {
    // TODO: implement userGet
    throw UnimplementedError();
  }

  @override
  Future<bool> userIsAuth() async {
    return await google.isSignedIn();
  }

  @override
  Future<GoogleSignInAccount?> userSignIn() async {
    return await google.signIn();
  }

  @override
  Future<GoogleSignInAccount?> userSignOut() async {
    return await google.signOut();
  }
}
