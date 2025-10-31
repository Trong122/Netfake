import '../repositories/auth_repository.dart';
import '../emtities/user_entity.dart';

class SignIn {
  final AuthRepository _repository;

  SignIn(this._repository);

  Future<UserEntity?> call({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}
