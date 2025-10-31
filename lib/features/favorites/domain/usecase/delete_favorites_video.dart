import '../repositories/favorites_repository.dart';

class DeleteVideo {
  final FavoritesVideoReporitory repository;

  DeleteVideo(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteFavoritesVideo(id);
  }
}