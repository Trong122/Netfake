import '../entities/favorites_video.dart';
import '../repositories/favorites_repository.dart';

class GetAllFavoritesVideo {
  final FavoritesVideoReporitory reporitory;
  GetAllFavoritesVideo(this.reporitory);

  // Future<List<FavoritesVideo>> call() => reporitory.getAllFavoritesVideo();
  Future<List<FavoritesVideo>> call(String userId) async {
    return await reporitory.getAllFavoritesVideo(userId);
  }
}
