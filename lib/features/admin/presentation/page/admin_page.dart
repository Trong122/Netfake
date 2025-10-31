import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/features/video/domain/entities/video.dart';
import 'package:netfake/features/video/domain/provider/video_provider_domain.dart';
import '../provider/admin_provdier.dart';
import 'add_video_page.dart';
import '../../../../core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(videoListProvider);
    final videoAsync = ref.watch(videoListProvider);
    final deleteVideo = ref.read(deleteVideoUsecaseProvider);

    return videoAsync.when(
      data: (videos) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/Logo.svg', width: 30, height: 30),
              const SizedBox(width: 8),
              const Text("NetFake"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.push(AppRoutes.searchAdmin);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            openForm(context, ref);
          },
          label: const Text('Thêm phim'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: [
            // Nội dung chính
            videos.isEmpty
                ? const Center(
                    child: Text(
                      'Không có phim',
                      style: TextStyle(color: Color.fromARGB(255, 73, 35, 35)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return Card(
                        color: const Color(0xFF1A1A1A),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            video.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            video.description,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  openForm(context, ref, video: video);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await deleteVideo(video.id);
                                  ref.invalidate(videoListProvider);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            // Nút Home ở góc dưới bên trái
            Positioned(
              bottom: 16,
              left: 16,
              child: FloatingActionButton(
                heroTag: 'homeBtn',
                onPressed: () {
                  context.go(AppRoutes.home); // điều hướng về Home
                },
                backgroundColor: Colors.red,
                child: const Icon(Icons.home),
              ),
            ),
          ],
        ),
      ),
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Lỗi: $error',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

Future<void> openForm(BuildContext context, WidgetRef ref, {Video? video}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => AddMovieScreen(video: video)),
  );
}
