import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/core/data/firebase_providers.dart';
import '../../domain/repositories/auth_repository.dart'; // Interface
import '../../data/repository/auth_repository_ipml.dart'; // Implementation

// GIẢ SỬ bạn cũng có provider này (tương tự như firebaseAuthProvider)
// Nếu chưa có, hãy thêm nó vào file 'firebase_providers.dar

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // 1. "SỬ DỤNG" (watch) FirebaseAuth
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  // 2. "SỬ DỤNG" (watch) FirebaseFirestore
  final firestore = ref.watch(firestoreProvider); // <-- THÊM DÒNG NÀY

  // 3. "Tiêm" (inject) CẢ HAI vào implementation
  return FirebaseAuthRepository(firebaseAuth, firestore); // <-- SỬA DÒNG NÀY
});