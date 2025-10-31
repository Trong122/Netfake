import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netfake/features/auth/domain/provider/auth_domain_provider.dart';
import '../../domain/emtities/user_entity.dart';
import '../../../../core/data/firebase_providers.dart';


class AuthController extends AsyncNotifier<UserEntity?> {
  @override
  FutureOr<UserEntity?> build() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return UserEntity(
        id: currentUser.uid,
        email: currentUser.email ?? '',
        displayName: currentUser.displayName ?? '',
      );
    }
    return null;
  }

 Future<void> signIn(String email, String password) async {
  state = const AsyncValue.loading();
  try {
    // 1️⃣ Gọi usecase SignIn (đã xử lý đầy đủ trong Repository)
    final signInUsecase = ref.read(SignInUsecaseProvider);
    final userEntity = await signInUsecase(email: email, password: password);

    // 2️⃣ Cập nhật state (vì userEntity đã có role + displayName)
    state = AsyncValue.data(userEntity);
  } on FirebaseAuthException catch (e, s) {
    state = AsyncValue.error(e.message ?? "Lỗi đăng nhập Firebase", s);
  } catch (e, s) {
    state = AsyncValue.error(e.toString(), s);
  }
}
Future<void> signUp(String email, String password, String displayName) async {
  state = const AsyncValue.loading();
  try {
    await ref.read(SignUpUseCaseProvider)(
      email: email,
      password: password,
      displayName: displayName,
    );
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUser = firebaseAuth.currentUser;
    state = currentUser != null
        ? AsyncValue.data(UserEntity(
            id: currentUser.uid,
            email: currentUser.email ?? '',
            displayName: currentUser.displayName ?? '',
            role: 'user',
          ))
        : const AsyncValue.data(null);
  } catch (e, s) {
    state = AsyncValue.error(e.toString(), s);
  }
}

  Future<void> signOut() async {
    final signOutUsecase = ref.read(SignOutUsecaseProvider);

    state = const AsyncValue.loading();
    try {
      await signOutUsecase();
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e, s) {
      state = AsyncValue.error(e.message ?? "Lỗi đăng xuất", s);
    } catch (e, s) {
      state = AsyncValue.error("Đã xảy ra lỗi không xác định", s);
    }
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, UserEntity?>(() => AuthController());
