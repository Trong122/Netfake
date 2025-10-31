import '../entities/video.dart';
import '../repositories/video_repository.dart';

class UpdateVideo {
  final VideoReporitory repository;

  UpdateVideo(this.repository);

  Future<void> call(Video video) async {
    await repository.updateVideo(video);
  }
}
