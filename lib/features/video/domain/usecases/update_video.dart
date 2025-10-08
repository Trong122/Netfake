import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class UpdateVideo {
  final VideoReporitory repository;

  UpdateVideo(this.repository);

  
  Future<VideoEntity> call(VideoEntity) => repository.updateVideo(VideoEntity);
}