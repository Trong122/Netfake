import 'package:flutter/material.dart';
// import '../../../features/Screens/video_detail_screen.dart'; // Không cần nữa
import 'package:netfake/features/video/domain/entities/video.dart';

class VideoCardRating extends StatelessWidget {
  final Video video;
  final VoidCallback? onTap;

  const VideoCardRating({Key? key, required this.video, this.onTap})
      : super(key: key);

  // --- HÀM HELPER ĐỂ TẠO SAO RATING ---
  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor(); // Số sao đầy
    bool hasHalfStar = (rating - fullStars) >= 0.5; // Có sao nửa không

    // Thêm sao đầy
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber, size: 16));
    }
    // Thêm sao nửa (nếu có)
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.amber, size: 16));
    }
    // Thêm sao rỗng cho đủ 5 sao
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.amber, size: 16));
    }
    return stars;
  }
  // ------------------------------------

  @override
  Widget build(BuildContext context) {
    // Giả sử rating có thể null, gán giá trị mặc định là 0.0
    final double currentRating = video.rating; 

    return SizedBox(
      width: 120,
      child: InkWell(
        onTap: onTap, // Sử dụng onTap được truyền vào
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Phần ảnh (Đã tối ưu) ---
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(video.imageUrl), // Giữ fallback
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // -----------------------------

            const SizedBox(height: 5),

            // Tiêu đề
            Text(
              video.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600, // Có thể in đậm nhẹ
              ),
            ),

            const SizedBox(height: 3), // Khoảng cách nhỏ trước rating

            // --- PHẦN RATING MỚI THÊM ---
            Row(
              children: _buildRatingStars(currentRating),
            ),
            // ---------------------------
          ],
        ),
      ),
    );
  }
}