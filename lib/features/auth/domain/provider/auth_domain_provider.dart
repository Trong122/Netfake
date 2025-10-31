import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/features/auth/data/provider/auth_provider.dart';
import '../../domain/usecase/sign_in.dart';
import '../../domain/usecase/sign_out.dart';
import '../../domain/usecase/sign_up.dart';

final SignInUsecaseProvider = Provider<SignIn>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignIn(repository);
});


final SignOutUsecaseProvider = Provider<SignOut>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignOut(repository);
});


final SignUpUseCaseProvider= Provider<SignUp>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUp(repository);
});
