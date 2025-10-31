import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDS<T> {
  final FirebaseFirestore firestore;
  // final FirebaseAuth auth;
  final String collectionName;
  final T Function(DocumentSnapshot doc) fromFirestore;
  final Map<String, dynamic> Function(T item) toFirestore;
  final String? defaultOrderBy;
  final bool descending;

  FirebaseRemoteDS({
    required this.firestore,
    // required this.auth,
    required this.collectionName,
    required this.fromFirestore,
    required this.toFirestore,
    this.defaultOrderBy, // Cho phép cấu hình field để sắp xếp
    this.descending = true,
  });

  CollectionReference get _collection => firestore.collection(collectionName);

  Future<List<T>> getAll() async {
    Query query = _collection;
    if (defaultOrderBy != null) {
      query = query.orderBy(defaultOrderBy!, descending: descending);
    }
    final snapshot = await query.get();
    return snapshot.docs.map((e) => fromFirestore(e)).toList();
  }

/// Lấy một video theo document ID
Future<T?> getById(String id) async {
  final doc = await _collection.doc(id).get();
  if (doc.exists) {
    return fromFirestore(doc);
  }
  // Nếu không tìm thấy document, trả về null
  return null;
}

  Future<String> add(T item) async {
    final data = toFirestore(item);
    data['created_at'] = FieldValue.serverTimestamp();
    final docRef = await _collection.add(data);
    return docRef.id;
  }

  Future<void> update(String id, T item) async {
    final data = toFirestore(item);
    await _collection.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }

  Stream<List<T>> watchAll() {
    Query query = _collection;
    if (defaultOrderBy != null) {
      query = query.orderBy(defaultOrderBy!, descending: descending);
    }
    return query.snapshots().map(
      (snapshot) => snapshot.docs.map((e) => fromFirestore(e)).toList(),
    );
  }

  // String? getUserId() {
  //   return auth.currentUser?.uid;
  // }
}
