import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/user_repository.dart';

class UserAuthenticatedClient implements UseCase<AuthClient?, void> {
  final UserRepository userRepository;
  UserAuthenticatedClient({required this.userRepository});

  @override
  Future<AuthClient?> call(void params) async {
    return await userRepository.authenticatedClient();
  }
}

