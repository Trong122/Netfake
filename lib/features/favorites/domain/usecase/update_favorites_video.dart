import '../entities/favorites_video.dart';
import '../repositories/favorites_repository.dart';

class UpdateVideo {
  final FavoritesVideoReporitory repository;

  UpdateVideo(this.repository);

  Future<void> call(FavoritesVideo video) async {
    await repository.updateFavoritesVideo(video);
  }
}
