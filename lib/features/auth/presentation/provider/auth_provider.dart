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
    // 1. Sign in với FirebaseAuth
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final currentUser = userCredential.user;
    if (currentUser == null) throw Exception("Không lấy được user");

    // 2. Load dữ liệu Firestore riêng về role
    final firestore = ref.read(firestoreProvider);
    final docSnapshot = await firestore.collection('users').doc(currentUser.uid).get();

    if (!docSnapshot.exists) throw Exception("User document không tồn tại");

    final data = docSnapshot.data()!;
    final role = data['role'] ?? 'user';

    // 3. Sau khi load xong, set state
    state = AsyncValue.data(
      UserEntity(
        id: currentUser.uid,
        email: currentUser.email ?? '',
        displayName: currentUser.displayName ?? '',
        role: role,
      ),
    );

    // print("Role của user: $role"); // debug

  } on FirebaseAuthException catch (e, s) {
    state = AsyncValue.error(e.message ?? "Lỗi đăng nhập", s);
  } catch (e, s) {
    state = AsyncValue.error(e.toString(), s);
  }
}

  Future<void> signUp(String email, String password, String display) async {
    final signUpUsecase = ref.read(SignUpUseCaseProvider);

    state = const AsyncValue.loading();
    try {
      await signUpUsecase(
        email: email,
        password: password,
        displayName: display,
      );

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        state = AsyncValue.data(
          UserEntity(
            id: currentUser.uid,
            email: currentUser.email ?? '',
            displayName: currentUser.displayName ?? '',
          ),
        );
      } else {
        state = const AsyncValue.data(null);
      }
    } on FirebaseAuthException catch (e, s) {
      state = AsyncValue.error(e.message ?? "Lỗi đăng ký", s);
    } catch (e, s) {
      state = AsyncValue.error("Đã xảy ra lỗi không xác định", s);
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
