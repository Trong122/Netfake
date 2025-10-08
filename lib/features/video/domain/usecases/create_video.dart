import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class CreateVideo {
  final VideoReporitory repository;

  CreateVideo(this.repository);

  Future<VideoEntity> call(VideoEntity) => repository.uploadVideo(VideoEntity);

}
 
