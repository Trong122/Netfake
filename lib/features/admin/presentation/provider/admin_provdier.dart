import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../video/domain/entities/video.dart';
import '../../../video/domain/provider/video_provider_domain.dart';

// import '../../data/model/video_model.dart';
// Provider để lấy danh sách video từ UseCase (dành cho UI)
final videoListProvider = FutureProvider<List<Video>>((ref) async {
  final getAllVideos = ref.watch(getAllVideoUsecaseProvider);
  return await getAllVideos();
});

final videoByIdProvider = FutureProvider.family<Video, String>((ref, id) async {
  final getVideoUsecase = ref.watch(getVideoByIdUsecaseProvider);
  final videoData = await getVideoUsecase(id: id);
  return videoData;
});
final deleteVideoByIdProvider = FutureProvider.family<void, String>((ref,id,) async {

  final deleteVideo = ref.read(deleteVideoUsecaseProvider);
  await deleteVideo(id);
});
final addVideoProvider = Provider<Future<void> Function(Video)>((ref) {
  final addVideo = ref.read(addVideoUsecaseProvider);
  return (Video video) async {
    await addVideo(video);
  };
});

final updateVideoProvider = Provider<Future<void> Function(Video)>((ref) {
  final updateVideo = ref.read(updateVideoUsecaseProvider);
  return (Video video) async {
    await updateVideo(video);
  };
});