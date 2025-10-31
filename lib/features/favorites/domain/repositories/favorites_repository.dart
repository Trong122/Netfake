import '../entities/favorites_video.dart';

abstract class FavoritesVideoReporitory {
  Future<List<FavoritesVideo>> getAllFavoritesVideo();
  Future<FavoritesVideo?> getFavoritesVideoById(String id);
  Future<void> addFavoritesVideo(FavoritesVideo FavoritesVideo,String id);
  Future<void> deleteFavoritesVideo(String id);
  Future<void> updateFavoritesVideo(FavoritesVideo FavoritesVideo);
  Future<bool> isFavorite(String userId, String videoId);
}
