import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../video/domain/entities/video.dart';
import '../../../../core/presentation/widget/video_rating.dart';
import '../../../auth/presentation/provider/auth_provider.dart';
import '../../domain/entities/favorites_video.dart';
import '../../presentation/provider/favorites_ui_provider.dart';
import 'package:go_router/go_router.dart';
import '/core/routing/app_routes.dart';
import '../../data/provider/favorites_video_provider_data.dart';

class VideoDetailScreen extends ConsumerStatefulWidget {
  final Video video;
  const VideoDetailScreen({super.key, required this.video});

  @override
  ConsumerState<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends ConsumerState<VideoDetailScreen> {
  bool? isFavorite;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return;
    final repo = ref.read(FavoritesvideoRepositoryProvider);
    try {
      final fav = await repo.isFavorite(user.id, widget.video.id);
      if (mounted) {
        setState(() {
          isFavorite = fav;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          isFavorite = false; // default false nếu lỗi
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    final user = ref.read(authControllerProvider).value;
    if (user == null || isFavorite == null) return;
    final favoriteVideo = FavoritesVideo(userId: user.id, video: widget.video);

    try {
      if (isFavorite!) {
        await ref.read(favoritesVideoDeleteProvider)(widget.video.id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Đã hủy thích video!")));
      } else {
        await ref.read(favoritesVideoAddProvider).call(favoriteVideo, user.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đã thêm video yêu thích!")),
        );
      }

      // Cập nhật state local
      setState(() {
        isFavorite = !isFavorite!;
      });

      // Cập nhật danh sách favorites
      ref.invalidate(FavoritesvideoListProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lỗi: Không thể thay đổi video yêu thích"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SvgPicture.asset('assets/Logo.svg', width: 40, height: 40),
            const SizedBox(width: 10),
            Text(
              "NetFake",
              style: TextStyle(
                fontSize: 25.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    video.imageUrl,
                    width: 120,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      RatingStars(rating: video.rating),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.push(AppRoutes.watch, extra: video);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text("Xem Phim"),
                            ),
                          ),
                          IconButton(
                            onPressed: isFavorite == null
                                ? null
                                : _toggleFavorite,
                            icon: Icon(
                              Icons.favorite,
                              color: (isFavorite ?? false)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                video.description,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
