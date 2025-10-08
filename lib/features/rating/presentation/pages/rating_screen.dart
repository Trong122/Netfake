import 'package:flutter/material.dart';

class RatingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> movies = [
    {"rank": 1, "title": "Avenger: End game", "rating": 5, "image": "assets/avengers.jpg"},
    {"rank": 2, "title": "IF", "rating": 3, "image": "assets/avengers.jpg"},
    {"rank": 3, "title": "Point Break", "rating": 4, "image": "assets/avengers.jpg"},
    {"rank": 4, "title": "Hunger", "rating": 4, "image": "assets/avengers.jpg"},
    {"rank": 5, "title": "Abigail", "rating": 2, "image": "assets/avengers.jpg"},
    {"rank": 6, "title": "Atlas", "rating": 3, "image": "assets/avengers.jpg"},
    {"rank": 7, "title": "Hit Man", "rating": 3, "image": "assets/avengers.jpg"},
    {"rank": 8, "title": "Ninja: Shadow of a Tear", "rating": 3, "image": "assets/avengers.jpg"},
    {"rank": 9, "title": "Ninja", "rating": 3, "image": "assets/avengers.jpg"},
    {"rank": 10, "title": "Ninja", "rating": 2, "image": "assets/avengers.jpg"},
  ];
  RatingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            children: [
              // Tiêu đề
              const Text(
                "Top Phim Hay Nhất",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Danh sách phim
              Column(
                children: movies.map((movie) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Số thứ tự
                        CircleAvatar(
                          backgroundColor: Colors.grey[700],
                          radius: 18,
                          child: Text(
                            "${movie["rank"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Thông tin phim
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie["title"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    size: 14,
                                    color: index < movie["rating"]
                                        ? Colors.redAccent
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Ảnh phim
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            movie["image"],
                            height: 60,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
