import '../../domain/repositories/favorites_repository.dart';
import '../data/video_remote_datasource.dart';
import '../model/video_model.dart';
import '../../domain/entities/favorites_video.dart';

class FavoritesVideoRepositoryImpl extends FavoritesVideoReporitory {
  final FavoritesVideoRemoteDataSource remoteDataSource;

  FavoritesVideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<FavoritesVideo>> getAllFavoritesVideo() async {
    final videosMD = await remoteDataSource.getAllVideo();
    return videosMD.map((e) => e.toEntity()).toList();
  }
  Future<List<FavoritesVideo>> getAllVideo(String userId) async {
  final videosMD = await remoteDataSource.getAllVideo(); // Lấy toàn bộ
  // Lọc theo userId
  final userFavs = videosMD.where((v) => v.userId == userId).toList();
  return userFavs.map((e) => e.toEntity()).toList();
}
  @override
  Future<FavoritesVideo> getFavoritesVideoById(String id) async {
    final videoMD = await remoteDataSource.getVideo(id);
    if (videoMD == null) throw Exception("Video not found");
    return videoMD.toEntity();
  }

  @override
  Future<void> addFavoritesVideo(FavoritesVideo video,String id) async {
    final videoMD = FavoritesVideoModel.fromEntity(video);
    // Lấy userId từ entity để truyền xuống datasource
    await remoteDataSource.addVideo(videoMD, video.userId);
  }

  @override
  Future<void> updateFavoritesVideo(FavoritesVideo video) async {
    final videoMD = FavoritesVideoModel.fromEntity(video);
    await remoteDataSource.updateVideo(videoMD);
  }

  @override
  Future<void> deleteFavoritesVideo(String id) async {
    await remoteDataSource.deleteVideo(id);
  }
   @override
  Future<bool> isFavorite(String userId, String videoId) async {
    final favs = await getAllVideo(videoId);
    return favs.any((fav) => fav.video.id == videoId);
  }
}
