import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widget/video_card.dart';
import '../../presentation/provider/favorites_ui_provider.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    // Invalidate provider sau khi widget build xong để load lại dữ liệu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(FavoritesvideoListProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(FavoritesvideoListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Tủ phim yêu thích',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có phim yêu thích 🥲',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // Map FavoritesVideo -> Video
          final videosList = favorites.map((f) => f.video).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: videosList.map((video) {
                return VideoCard(video: video);
              }).toList(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text(
            'Lỗi tải phim yêu thích: $err',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
