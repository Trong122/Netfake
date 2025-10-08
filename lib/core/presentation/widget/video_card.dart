import 'package:flutter/material.dart';
import 'package:netfake/features/video/domain/entities/video_entity.dart';
import '../../../features/Screens/video_detail_screen.dart';
import '../../../features/video/domain/entities/video_entity.dart';
import '../../model/videoview_model.dart';

class VideoCard extends StatelessWidget {
final VideoModel video;
  final VoidCallback? onTap; // để click mở chi tiết

  const VideoCard({
    Key? key,
    required this.video,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoDetailScreen(
                title: video.title,
                imageUrl: video.imageUrl ?? "assets/aven1.jpeg",
                description: video.description ?? "no description",
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                video.imageUrl ?? "assets/aven1.jpeg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              video.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
