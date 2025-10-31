  import 'package:flutter/material.dart';
  import '../../../../core/presentation/widget/video_card.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import '../../presentation/provider/video_ui_provider.dart'; // đường dẫn tùy theo cấu trúc của bạn


  class HomeScreen extends ConsumerWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final videoAsync = ref.watch(videoListProvider);

      return videoAsync.when(
        data: (videos) {
          final moviesNewest = videos .take(5).toList(); // hoặc lọc theo thuộc tính
          final moviesHost = videos.take(5).toList();
          final banners = videos.take(5).toList();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner ngang
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: banners.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(banners[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Section "Mới nhất"
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Mới nhất",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // List phim kéo ngang
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: moviesNewest.length,
                    itemBuilder: (context, index) {
                      final video = moviesNewest[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VideoCard(video: video),
                      );
                    },
                  ),
                ),
                // Tiêu đề "Phim hot"
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Phim hot",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: moviesHost.length,
                    itemBuilder: (context, index) {
                      final video = moviesHost[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VideoCard(video: video),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Lỗi: $e', style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }
