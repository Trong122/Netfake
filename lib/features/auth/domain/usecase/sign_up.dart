import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository _authRepository;

  SignUp(this._authRepository);

  Future<void> call({required String email, required String password,required String displayName}) {
  return _authRepository.signUp(email: email, password: password,displayName: displayName);
}
}