// Thêm 2 import này
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/emtities/user_entity.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore; // <-- 1. Thêm Firestore

  // 2. Cập nhật constructor
  FirebaseAuthRepository(this._firebaseAuth, this._firestore);

  // Chúng ta sẽ không dùng hàm _userFromFirebase nữa
  // vì chúng ta cần lấy dữ liệu từ 2 nguồn (Auth và Firestore)

  @override
  Future<UserEntity> signIn({required String email, required String password}) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Đăng nhập thất bại, không tìm thấy user.');
    }
    // 3. ĐỌC VAI TRÒ (ROLE) TỪ FIRESTORE
    final doc = await _firestore.collection('users').doc(user.uid).get();
    // Nếu không tìm thấy doc (lỗi đồng bộ), tạm gán là 'user'
    final role = doc.data()?['role'] ?? 'user'; 
    // 4. Trả về UserEntity hoàn chỉnh
    return UserEntity(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      role: role, // <-- Lấy role từ Firestore
    );
  }

  @override
  Future<UserEntity?> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    UserCredential? credential;
    try {
      // 1. Tạo user trong Auth
      credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw Exception("Không thể tạo người dùng.");
      }

      final newRole = 'user'; // Vai trò mặc định khi đăng ký

      // 2. GHI VAI TRÒ (ROLE) VÀO FIRESTORE (Như code lần trước)
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'displayName': displayName,
        'role': newRole, // <-- Gán vai trò ở đây
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. Cập nhật displayName trong Auth
      await user.updateDisplayName(displayName);
      await user.reload();

      final reloadedUser = _firebaseAuth.currentUser!;

      // 4. Trả về UserEntity hoàn chỉnh
      return UserEntity(
        id: reloadedUser.uid,
        email: reloadedUser.email,
        displayName: reloadedUser.displayName,
        role: newRole, // Trả về vai trò vừa được tạo
      );
    } catch (e) {
      // Nếu ghi Firestore lỗi, xóa user vừa tạo trong Auth để đồng bộ
      if (credential?.user != null) {
        await credential!.user!.delete();
      }
      print('Lỗi đăng ký: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Sửa stream để kết hợp Auth và Firestore
  @override
  Stream<UserEntity?> get user {
    // 1. Lắng nghe thay đổi trạng thái Auth
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      // Nếu user là null (đã đăng xuất)
      if (firebaseUser == null) {
        return null;
      }

      // 2. Nếu có user, lấy vai trò (role) của họ từ Firestore
      try {
        final doc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();
        
        final role = doc.data()?['role'] ?? 'user'; // Mặc định là 'user'

        return UserEntity(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          displayName: firebaseUser.displayName,
          role: role, // <-- Gắn vai trò vào stream
        );
      } catch (e) {
        // Nếu lỗi khi đọc Firestore, tạm trả về user với role mặc định
        return UserEntity(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          displayName: firebaseUser.displayName,
          role: 'user', 
        );
      }
    });
  }
}