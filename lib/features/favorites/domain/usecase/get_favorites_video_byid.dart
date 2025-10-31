import '../repositories/favorites_repository.dart';
import '../entities/favorites_video.dart';
class GetFavoritesVideoById {
  final FavoritesVideoReporitory repository;

  GetFavoritesVideoById(this.repository);

 Future<FavoritesVideo?> call(String videoId) async {
    // Trả về video nếu tồn tại, null nếu không có
    return await repository.getFavoritesVideoById(videoId);
  }
}
