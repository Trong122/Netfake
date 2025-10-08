import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
// import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_video.dart';
import '../../domain/usecases/delete_video.dart';
import '../../domain/usecases/update_video.dart';
import '../../domain/usecases/get_video.dart';
class VideoController extends StateNotifier<AsyncValue<void>> {
  final CreateVideo createVideo;
  final UpdateVideo updateVideo;
  final DeleteVideo deleteVideo;
  final GetVideo getVideo;
  VideoController({
    required this.createVideo,
    required this.updateVideo,
    required this.deleteVideo,
    required this.getVideo,
  }) :super(const AsyncValue.data(null));

  Future<void> createVideoFunction(video) async {
    state =const AsyncValue.loading();
    try{
      await createVideo(video);
      state =const AsyncValue.data(null);
    }catch(e){
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
  Future<void> updateVideoFunction(video) async {
    state =const AsyncValue.loading();
    try{
      await updateVideo(video);
      state =const AsyncValue.data(null);
    }catch(e){
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
  Future<void> deleteVideoFunction(id) async {
    state =const AsyncValue.loading();
    try{
      await deleteVideo(id);
      state =const AsyncValue.data(null);
    }catch(e){
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
  Future<void> getVideoFunction(id) async {
    state =const AsyncValue.loading();
    try{
      await getVideo(id);
      state =const AsyncValue.data(null);
    }catch(e){
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}