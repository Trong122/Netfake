import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/core/data/firebase_providers.dart';
import '../../data/model/video_model.dart';
import '../../../../core/data/firebase_remote_data_source2.dart';
import '../../data/data/video_remote_datasource.dart';
import '../../domain/repositories/video_repository.dart'; // Interface
import '../../data/repositories/video_repository_impl.dart'; // Implementation


// ----- PROVIDER DATA SOURCE -----
final _videoFirebaseDSProvider = Provider<FirebaseRemoteDS<VideoModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirebaseRemoteDS<VideoModel>(
    firestore: firestore,
    collectionName: 'video',
    fromFirestore: (doc) => VideoModel.fromFirestore(doc),
    toFirestore: (model) => model.toJson(),
  );
});

// ----- PROVIDER REMOTE DATA SOURCE -----
final videoRemoteDataSourceProvider = Provider<VideoRemoteDataSource>((ref) {
  final remoteDS = ref.watch(_videoFirebaseDSProvider);
  return VideoRemoteDataSourceImpl(remoteDS);
});

// ----- PROVIDER REPOSITORY -----
final videoRepositoryProvider = Provider<VideoReporitory>((ref) {
  final remoteDataSource = ref.watch(videoRemoteDataSourceProvider);
  return VideoRepositoryImpl(remoteDataSource);
});