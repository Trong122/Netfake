import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class GetVideo {
  final VideoReporitory repository;

  GetVideo(this.repository);

   Future<VideoEntity> call(VideoEntity) => repository.getVideoById(VideoEntity);
}
