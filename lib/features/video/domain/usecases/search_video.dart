import '../entities/video.dart';
import '../repositories/video_repository.dart';

class SearchVideo {
  final VideoReporitory repository;
  SearchVideo(this.repository);
  Future<List<Video>> call({required String title}) async {
    return await repository.searchVideo(title);
  }
}
