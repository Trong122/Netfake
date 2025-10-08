import 'package:flutter/material.dart';
import 'package:netfake/core/model/videoview_model.dart';
import '../../../../core/presentation/widget/video_card.dart';
class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final List<Map<String, String>> moviesNewest = [
    {"title": "Harry Potter", "poster": "assets/aven1.jpeg","description":"Phim về phù thủy"} ,
    {"title": "Avengers Endgame", "poster": "assets/aven1.jpeg","description":"Phim về siêu anh hùng"},
    {"title": "Furiosa", "poster": "assets/aven1.jpeg","description":"Phim về chiến binh"},
    {"title": "Deadpool", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ"},
    {"title": "Deadpool 2", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 2"},
    {"title": "Deadpool 3", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 3"},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Khung chính
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Ảnh nền (poster)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      "assets/avengers.jpg", // ảnh poster Batman
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Avatar + Info
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            "assets/avatar.png", // thay bằng ảnh avatar
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Tên + Email
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Nguyễn Văn A",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "NVA@gmail.com",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Hàng thống kê
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatCard(title: "Số phim đã xem", value: "100"),
                const SizedBox(width: 12),
                _StatCard(title: "Thời gian xem", value: "24m30d23h"),
              ],
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Text("Yêu thích",
                style:TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemCount: moviesNewest.length,
                itemBuilder: (context, index) {
                  final movie = moviesNewest[index];
                  return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: VideoCard(
                    video:VideoModel(title: movie["title"]??"no title", 
                    imageUrl: movie["poster"]??"assets/aven1.jpeg", 
                    description: movie["description"]??"no description",
                    ),
                  ),
                );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget cho card thống kê
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );

  }
}
