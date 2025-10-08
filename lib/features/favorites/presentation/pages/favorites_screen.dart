import 'package:flutter/material.dart';
import 'package:netfake/core/presentation/widget/video_card.dart';
import 'package:netfake/core/model/videoview_model.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, String>> moviesHost = [
    {"title": "Harry Potter", "poster": "assets/aven1.jpeg", "description": "Phim về phù thủy"},
    {"title": "Avengers Endgame", "poster": "assets/aven1.jpeg", "description": "Phim về siêu anh hùng"},
    {"title": "Furiosa", "poster": "assets/aven1.jpeg", "description": "Phim về chiến binh"},
    {"title": "Deadpool", "poster": "assets/aven1.jpeg", "description": "Phim về sát thủ"},
    {"title": "Deadpool 2", "poster": "assets/aven1.jpeg", "description": "Phim về sát thủ 2"},
    {"title": "Deadpool 3", "poster": "assets/aven1.jpeg", "description": "Phim về sát thủ 3"},
  ];

  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // ✅ đảm bảo cao ít nhất = màn hình, nhưng có thể mở rộng
            constraints: BoxConstraints(minHeight: screenHeight),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tủ phim',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ hiển thị phim dạng lưới mềm mại
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(moviesHost.length, (index) {
                    final movie = moviesHost[index];
                    return VideoCard(
                      video:VideoModel(title: movie["title"]??"no title",
                       imageUrl: movie["poster"]??"assets/aven1.jpeg", 
                       description: movie["description"]??"no description",
                       ),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // ✅ chỉ hiển thị text cuối nếu phim ít
                Center(
                  child: Text(
                    moviesHost.isEmpty
                        ? 'Chưa có phim yêu thích 🥲'
                        : '— Hết phim yêu thích rồi —',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
