import '../../../../core/data/firebase_remote_data_source2.dart';
import '../model/video_model.dart';

abstract class FavoritesVideoRemoteDataSource {
  Future<List<FavoritesVideoModel>> getAllVideo();
  Future<FavoritesVideoModel?> getVideo(String id);
  Future<void> addVideo(FavoritesVideoModel vd,String uerId);
  Future<void> updateVideo(FavoritesVideoModel vd);
  Future<void> deleteVideo(String id);
}

class VideoRemoteDataSourceImpl implements FavoritesVideoRemoteDataSource{
  final FirebaseRemoteDS<FavoritesVideoModel> _remoteDs;
  VideoRemoteDataSourceImpl(this._remoteDs);    
  
  @override
  Future<List<FavoritesVideoModel>> getAllVideo() async {
    List<FavoritesVideoModel> video = [];
    video = await _remoteDs.getAll();
    return video;
  }

  @override
  Future<FavoritesVideoModel?> getVideo(String id) async {
    FavoritesVideoModel? video = await _remoteDs.getById(id);
    return video;
  }

  @override
 Future<void> addVideo(FavoritesVideoModel vd, String userId) async {
  final videoWithUser = FavoritesVideoModel(
    userId: userId,
    video: vd.video,
  );

  await _remoteDs.add(videoWithUser);
}

  @override
  Future<void> deleteVideo(String id) async {
    await _remoteDs.delete(id);
  }
  @override 
  Future<void> updateVideo(FavoritesVideoModel vd) async {
    await _remoteDs.update(vd.userId.toString(), vd);
  }
}
