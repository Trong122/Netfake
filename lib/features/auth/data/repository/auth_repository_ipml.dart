// Thêm 2 import này
import 'package:cloud_firestore/cloud_firestore.dart';
// Sửa lỗi gõ: 'emtities' -> 'entities'
import '../../domain/emtities/user_entity.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore; // <-- 1. Thêm Firestore

  // 2. Cập nhật constructor
  FirebaseAuthRepository(this._firebaseAuth, this._firestore);

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

    // 3. ĐỌC VAI TRÒ (ROLE) VÀ DỮ LIỆU TỪ FIRESTORE
    final doc = await _firestore.collection('users').doc(user.uid).get();
    
    if (!doc.exists) {
        // Trường hợp hiếm: user tồn tại trong Auth nhưng không có trong DB
        throw Exception('Không tìm thấy dữ liệu người dùng.');
    }
    
    final data = doc.data()!;
    final role = data['role'] ?? 'user'; 
    final displayName = data['displayName'] ?? user.displayName; // Lấy từ DB hoặc Auth

    // 4. Trả về UserEntity hoàn chỉnh
    return UserEntity(
      id: user.uid,
      email: user.email,
      displayName: displayName, // <-- Sửa: Thêm displayName
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

      // 2. GHI DỮ LIỆU VÀ VAI TRÒ (ROLE) VÀO FIRESTORE
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'displayName': displayName,
        'role': newRole, // <-- Gán vai trò ở đây
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. Cập nhật displayName trong Auth (vẫn nên làm)
      await user.updateDisplayName(displayName);
      await user.reload(); 

      final reloadedUser = _firebaseAuth.currentUser!;

      // 4. Trả về UserEntity hoàn chỉnh
      return UserEntity(
        id: reloadedUser.uid,
        email: reloadedUser.email,
        displayName: reloadedUser.displayName, // <-- Sửa: Thêm displayName
        role: newRole, // Trả về vai trò vừa được tạo
      );
    } catch (e) {
      // Xử lý lỗi: Nếu ghi Firestore lỗi, xóa user vừa tạo trong Auth
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
        
        if (!doc.exists) {
            // User đã đăng nhập nhưng chưa có doc trong db
            return null; 
        }

        final data = doc.data()!;
        final role = data['role'] ?? 'user';
        final displayName = data['displayName'] ?? firebaseUser.displayName;

        return UserEntity(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          displayName: displayName, // <-- Sửa: Thêm displayName
          role: role, // <-- Gắn vai trò vào stream
        );
      } catch (e) {
        // Nếu lỗi khi đọc Firestore
        print('Lỗi stream user: $e');
        return null;
      }
    });
  }
}