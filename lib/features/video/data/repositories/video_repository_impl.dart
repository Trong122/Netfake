import '../../domain/repositories/video_repository.dart';
import '../data/video_remote_datasource.dart';
import '../model/video_model.dart';
import '../../domain/entities/video.dart';

class VideoRepositoryImpl extends VideoReporitory {
  final VideoRemoteDataSource remoteDataSource;
  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Video>> getAllVideo() async {
    List<VideoModel> video = await remoteDataSource.getAllVideo();
    return video;
  }

  @override
  Future<Video> getVideoById(String id) async {
    VideoModel? videoMD = await remoteDataSource.getVideo(id);
    if (videoMD == null) {
      throw Exception("Video not found");
    }
    return videoMD;
  }

  @override
  Future<void> uploadVideo(Video video) async {
    VideoModel videoMD = VideoModel.fromEntity(video);
    await remoteDataSource.addVideo(videoMD);
  }

  @override
  Future<void> updateVideo(Video video) async {
    await remoteDataSource.updateVideo(VideoModel.fromEntity(video));
  }

  @override
  Future<void> deleteVideo(String id) async {
    await remoteDataSource.deleteVideo(id);
  }

  @override
  Future<List<Video>> searchVideo(String title) async {
  // Lấy tất cả video từ remoteDataSource
  final videos = await remoteDataSource.getAllVideo();

  // Lọc các video mà title chứa chuỗi tìm kiếm (không phân biệt hoa thường)
  final filtered = videos.where((video) {
    return video.title.toLowerCase().contains(title.toLowerCase());
  }).toList();

  return filtered;
  }
}
