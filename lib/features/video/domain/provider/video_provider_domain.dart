import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/add_video.dart';
import '../../domain/usecases/delete_video.dart';
import '../../domain/usecases/get_all_video.dart';
import '../../domain/usecases/update_video.dart';
import '../../data/provider/video_provider_data.dart';
import '../../domain/usecases/search_video.dart';
import '../../domain/usecases/get_video_by_id.dart';

// 1. Provider cho GetAllVideoUsecase
final getAllVideoUsecaseProvider = Provider<GetAllVideo>((ref) {
  // Lấy repository từ provider của tầng Data
  final repository = ref.watch(videoRepositoryProvider);

  // Tiêm (inject) repository vào lớp UseCase
  return GetAllVideo(repository);
});

// 2. Provider cho AddVideoUsecase
final addVideoUsecaseProvider = Provider<AddVideo>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return AddVideo(repository);
});

// 3. Provider cho UpdateVideoUsecase
final updateVideoUsecaseProvider = Provider<UpdateVideo>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return UpdateVideo(repository);
});

// 4. Provider cho DeleteVideoUsecase
final deleteVideoUsecaseProvider = Provider<DeleteVideo>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return DeleteVideo(repository);
});

final searchVideoUsecaseProvider = Provider<SearchVideo>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return SearchVideo(repository);
});

final getVideoByIdUsecaseProvider = Provider<GetVideoById>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return GetVideoById(repository);
});
