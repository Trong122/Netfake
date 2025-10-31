import '../entities/video.dart';
import '../repositories/video_repository.dart';

class AddVideo {
  final VideoReporitory repository;

  AddVideo(this.repository);

  Future<void> call(Video video) async {
    await repository.uploadVideo(video);
  }
}
