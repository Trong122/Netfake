import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/favorites_video.dart';
import '../../domain/provider/favorites_video_domain_provider.dart';
import '../../../auth/presentation/provider/auth_provider.dart';
import '../../data/provider/favorites_video_provider_data.dart';
import '../../../../core/data/firebase_providers.dart';

// Provider để lấy danh sách video từ UseCase (dành cho UI)
final FavoritesvideoListProvider = FutureProvider<List<FavoritesVideo>>((
  ref,
) async {
  final getAllVideos = ref.watch(getAllVideoUsecaseProvider);
  return await getAllVideos();
});

final favoritesVideoAddProvider =
    Provider<Future<void> Function(FavoritesVideo video, String id)>((ref) {
      final addVideoUsecase = ref.watch(addVideoUsecaseProvider);

      return (FavoritesVideo video, String id) async {
        await addVideoUsecase(video, id);
      };
    });
final isFavoriteProvider = StreamProvider.autoDispose.family<bool, String>((
  ref,
  videoId,
) {
  // 2. Lấy user ID
  final user = ref.watch(authControllerProvider).value;
  if (user == null) {
    // Nếu chưa đăng nhập, trả về 1 stream có giá trị 'false'
    return Stream.value(false);
  }
  final firebase = ref.read(firestoreProvider);
  // 3. Lắng nghe (snapshots) document CỤ THỂ
  final docStream = firebase
      .collection('users')
      .doc(user.id) // Document của user
      .collection('favorites') // Collection 'favorites' của user đó
      .doc(videoId) // Document có ID là videoId
      .snapshots(); // .snapshots() trả về Stream<DocumentSnapshot>

  // 4. Map stream về giá trị boolean
  //    - 'snapshot.exists' sẽ là 'true' nếu doc tồn tại (đã like)
  //    - 'snapshot.exists' sẽ là 'false' nếu doc bị xóa (đã unlike)
  return docStream.map((snapshot) => snapshot.exists);
});
final favoritesVideoDeleteProvider = Provider<Future<void> Function(String id)>(
  (ref) {
    final deleteVideoUsecase = ref.watch(deleteVideoUsecaseProvider);

    return (String id) async {
      await deleteVideoUsecase(id);
    };
  },
);
final favoriteStatusProvider = FutureProvider.family<bool, String>((
  ref,
  videoId,
) async {
  final user = ref.read(authControllerProvider).value;
  if (user == null) return false;

  final repo = ref.read(FavoritesvideoRepositoryProvider);
  return await repo.isFavorite(user.id, videoId);
});
