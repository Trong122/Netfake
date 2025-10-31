import '../entities/video.dart';
import '../repositories/video_repository.dart';

class GetVideoById {
  final VideoReporitory repository;
  GetVideoById(this.repository);
  Future<Video> call({required String id}) async {
    return await repository.getVideoById(id);
  }
}
