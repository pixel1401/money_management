import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/user_repository.dart';

class UserSignIn implements UseCase<GoogleSignInAccount?, void> {
  final UserRepository userRepository;
  UserSignIn({required this.userRepository});

  @override
  Future<GoogleSignInAccount?> call(void params) async {
    return await userRepository.userSignIn();
  }
}
