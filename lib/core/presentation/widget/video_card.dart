import 'package:flutter/material.dart';
import 'package:netfake/features/video/domain/entities/video.dart';
import 'package:go_router/go_router.dart';
import '/core/routing/app_routes.dart';
class VideoCard extends StatelessWidget {
  final Video video;
  final VoidCallback? onTap; 

  const VideoCard({Key? key, required this.video, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Giới hạn chiều rộng
      child: InkWell(
        onTap: (){
          context.push(AppRoutes.detail,extra: video,);
        },
        borderRadius: BorderRadius.circular(8), // Cho hiệu ứng nhấn đẹp hơn
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Giúp Column ôm sát nội dung
          children: [
            Container(
              width: double.infinity, 
              height: 150,           
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Bo góc ở đây
                image: DecorationImage(
                  // Dùng DecorationImage nhanh hơn
                  image: AssetImage(video.imageUrl ), // Giữ fallback
                  fit: BoxFit.cover, 
                ),
              ),
            ),
            // --------------- HẾT PHẦN SỬA ẢNH ---------------

            const SizedBox(height: 5), // Khoảng cách

            // Tiêu đề video
            Text(
              video.title,
              maxLines: 1, 
              overflow: TextOverflow.ellipsis, 
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14 
              ),
            ),
          ],
        ),
      ),
    );
  }
}