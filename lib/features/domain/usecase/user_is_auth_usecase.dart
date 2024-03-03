import 'package:money_management/core/usecase/usecase.dart';
import 'package:money_management/features/domain/repository/user_repository.dart';

class UserIsAuth implements UseCase<bool?, void> {
  final UserRepository userRepository;
  UserIsAuth({required this.userRepository});

  @override
  Future<bool> call(void params) async {
    return await userRepository.userIsAuth();
  }
}

