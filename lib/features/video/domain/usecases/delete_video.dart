import '../repositories/video_repository.dart';

class DeleteVideo {
  final VideoReporitory repository;

  DeleteVideo(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteVideo(id);
  }
}