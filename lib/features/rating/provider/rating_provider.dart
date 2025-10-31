import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/video/domain/entities/video.dart';
import '../../../features/video/domain/provider/video_provider_domain.dart';

final videoListProvider = FutureProvider<List<Video>>((ref) async {
  final getAllVideos = ref.watch(getAllVideoUsecaseProvider);
  final videos = await getAllVideos();
  // Hoặc sắp xếp theo rating giảm dần
  videos.sort((a, b) => b.rating.compareTo(a.rating));
  return videos;
});
