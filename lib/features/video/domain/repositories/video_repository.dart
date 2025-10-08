import '../entities/video_entity.dart';

abstract class VideoReporitory {
  Future<List<VideoEntity>> fetchVideos({int page = 1, int limit = 10});
  Future<VideoEntity> getVideoById(String id);
  Future<VideoEntity> uploadVideo(VideoEntity video);
  Future<void> deleteVideo(String id);
  Future<VideoEntity> updateVideo(VideoEntity video);
}