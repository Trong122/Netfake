import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/core/data/firebase_providers.dart';
import '../../data/model/video_model.dart';
import '../../../../core/data/firebase_remote_data_source2.dart';
import '../../data/data/video_remote_datasource.dart';
import '../../domain/repositories/favorites_repository.dart'; // Interface
import '../repositories/favorites_video_repository_impl.dart'; // Implementation


// ----- PROVIDER DATA SOURCE -----
final _videoFirebaseDSProvider = Provider<FirebaseRemoteDS<FavoritesVideoModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirebaseRemoteDS<FavoritesVideoModel>(
    firestore: firestore,
    collectionName: 'favoritesvideo',
    fromFirestore: (doc) => FavoritesVideoModel.fromFirestore(doc),
    toFirestore: (model) => model.toJson(),
  );
});

// ----- PROVIDER REMOTE DATA SOURCE -----
final FavoritesvideoRemoteDataSourceProvider = Provider<FavoritesVideoRemoteDataSource>((ref) {
  final remoteDS = ref.watch(_videoFirebaseDSProvider);
  return VideoRemoteDataSourceImpl(remoteDS);
});

// ----- PROVIDER REPOSITORY -----
final FavoritesvideoRepositoryProvider = Provider<FavoritesVideoReporitory>((ref) {
  final remoteDataSource = ref.watch(FavoritesvideoRemoteDataSourceProvider);
  return FavoritesVideoRepositoryImpl(remoteDataSource);
});