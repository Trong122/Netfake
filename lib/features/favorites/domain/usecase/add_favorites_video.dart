import '../entities/favorites_video.dart';
import '../repositories/favorites_repository.dart';

class AddFavoritesVideo {
  final FavoritesVideoReporitory repository;

  AddFavoritesVideo(this.repository);

  Future<void> call(FavoritesVideo video,String id) async {
    await repository.addFavoritesVideo(video,id);
  }
}
