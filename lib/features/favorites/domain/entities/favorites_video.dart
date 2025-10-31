import '../../../video/domain/entities/video.dart';

class FavoritesVideo {
  final String userId;
  final Video video;
  const FavoritesVideo({
    required this.userId,
    required this.video,
  });
}
