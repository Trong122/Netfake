import '../../../../core/data/firebase_remote_data_source2.dart';
import '../model/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoModel>> getAllVideo();
  Future<VideoModel?> getVideo(String id);
  Future<void> addVideo(VideoModel vd);
  Future<void> updateVideo(VideoModel vd);
  Future<void> deleteVideo(String id);
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource{
  final FirebaseRemoteDS<VideoModel> _remoteDs;
  VideoRemoteDataSourceImpl(this._remoteDs);    
  
  @override
  Future<List<VideoModel>> getAllVideo() async {
    List<VideoModel> video = [];
    video = await _remoteDs.getAll();
    return video;
  }

  @override
  Future<VideoModel?> getVideo(String id) async {
    VideoModel? video = await _remoteDs.getById(id);
    return video;
  }

  @override
  Future<void> addVideo(VideoModel vd) async {
    await _remoteDs.add(vd);
  }

  @override
  Future<void> deleteVideo(String id) async {
    await _remoteDs.delete(id);
  }
  @override 
  Future<void> updateVideo(VideoModel vd) async {
    await _remoteDs.update(vd.id.toString(), vd);
  }
}
