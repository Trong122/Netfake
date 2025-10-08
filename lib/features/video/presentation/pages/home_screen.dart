import 'package:flutter/material.dart';
import 'package:netfake/core/model/videoview_model.dart';
import '../../../../core/presentation/widget/video_card.dart';
class HomeScreen extends StatelessWidget {
  final List<String> banners = [
    "assets/aven2.webp",
    "assets/aven2.webp",
    "assets/aven2.webp",
  ];

  final List<Map<String, String>> moviesNewest = [
    {"title": "Harry Potter", "poster": "assets/aven1.jpeg","description":"Phim về phù thủy"} ,
    {"title": "Avengers Endgame", "poster": "assets/aven1.jpeg","description":"Phim về siêu anh hùng"},
    {"title": "Furiosa", "poster": "assets/aven1.jpeg","description":"Phim về chiến binh"},
    {"title": "Deadpool", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ"},
    {"title": "Deadpool 2", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 2"},
    {"title": "Deadpool 3", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 3"},
  ];
  final List<Map<String, String>> moviesHost = [
    {"title": "Harry Potter", "poster": "assets/aven1.jpeg","description":"Phim về phù thủy"} ,
    {"title": "Avengers Endgame", "poster": "assets/aven1.jpeg","description":"Phim về siêu anh hùng"},
    {"title": "Furiosa", "poster": "assets/aven1.jpeg","description":"Phim về chiến binh"},
    {"title": "Deadpool", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ"},
    {"title": "Deadpool 2", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 2"},
    {"title": "Deadpool 3", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 3"},
  ];
  @override
  Widget build(BuildContext context) {
    print("Movies newest: $moviesNewest");
    print("Movies host: $moviesHost");
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
                      image: AssetImage(banners[index]),
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
              physics: ClampingScrollPhysics(), // 👈 đảm bảo scroll ngang hoạt động
              itemCount: moviesNewest.length,
              itemBuilder: (context, index) {
                final movie = moviesNewest[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: VideoCard(
                    video:VideoModel(title: movie["title"]??"no title", 
                    imageUrl: movie["imageUrl"]??"assets/aven1.jpeg", 
                    description: movie["description"]??"no description",
                    ),
                  ),
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
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = moviesHost[index];
                  return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: VideoCard(
                    video:VideoModel(title: movie["title"]??"no title", 
                    imageUrl: movie["imageUrl"]??"assets/aven1.jpeg", 
                    description: movie["description"]??"no description",
                    ),
                  ),
                );
                },
              ),
            ),
        ],
      ),
    );
  }
}
