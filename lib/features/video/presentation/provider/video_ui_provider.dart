import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/video.dart';
import '../../domain/provider/video_provider_domain.dart';
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
