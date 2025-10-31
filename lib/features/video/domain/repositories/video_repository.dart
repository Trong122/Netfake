import '../entities/video.dart';

abstract class VideoReporitory {
  Future<List<Video>> getAllVideo();
  Future<Video> getVideoById(String id);
  Future<void> uploadVideo(Video video);
  Future<void> deleteVideo(String id);
  Future<void> updateVideo(Video video);
  Future<List<Video>> searchVideo(String title);
}
