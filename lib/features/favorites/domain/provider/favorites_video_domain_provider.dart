import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/add_favorites_video.dart';
import '../../domain/usecase/delete_favorites_video.dart';
import '../../domain/usecase/get_all_video.dart';
import '../../domain/usecase/update_favorites_video.dart';
import '../../data/provider/favorites_video_provider_data.dart';
import '../../domain/usecase/get_favorites_video_byid.dart';

// 1. Provider cho GetAllVideoUsecase
final getAllVideoUsecaseProvider = Provider<GetAllFavoritesVideo>((ref) {
  // Lấy repository từ provider của tầng Data
  final repository = ref.watch(FavoritesvideoRepositoryProvider);

  // Tiêm (inject) repository vào lớp UseCase
  return GetAllFavoritesVideo(repository);
});

// 2. Provider cho AddVideoUsecase
final addVideoUsecaseProvider = Provider<AddFavoritesVideo>((ref) {
  final repository = ref.watch(FavoritesvideoRepositoryProvider);
  return AddFavoritesVideo(repository);
});

// 3. Provider cho UpdateVideoUsecase
final updateVideoUsecaseProvider = Provider<UpdateVideo>((ref) {
  final repository = ref.watch(FavoritesvideoRepositoryProvider);
  return UpdateVideo(repository);
});

// 4. Provider cho DeleteVideoUsecase
final deleteVideoUsecaseProvider = Provider<DeleteVideo>((ref) {
  final repository = ref.watch(FavoritesvideoRepositoryProvider);
  return DeleteVideo(repository);
});
final getVideoUsecaseProvider = Provider<GetFavoritesVideoById>((ref) {
  final repository = ref.watch(FavoritesvideoRepositoryProvider);
  return GetFavoritesVideoById(repository);
});
