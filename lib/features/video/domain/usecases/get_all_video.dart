import '../entities/video.dart';
import '../repositories/video_repository.dart';

class GetAllVideo {
  final VideoReporitory reporitory;
  GetAllVideo(this.reporitory);

  Future<List<Video>> call() => reporitory.getAllVideo();
}
