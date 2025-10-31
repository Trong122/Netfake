import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/features/video/domain/entities/video.dart';
import '../../../video/domain/provider/video_provider_domain.dart';

final searchVideoProvider = FutureProvider.family<List<Video>, String>((ref, title) async {
  if (title.isEmpty) return [];
  final searchUsecase = ref.watch(searchVideoUsecaseProvider);
  return await searchUsecase(title: title);
});
