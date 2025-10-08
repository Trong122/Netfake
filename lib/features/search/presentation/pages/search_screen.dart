import 'package:flutter/material.dart';
import 'package:netfake/core/presentation/widget/video_card.dart';
import 'package:netfake/core/model/videoview_model.dart';

class SearchScreen extends StatelessWidget {
  final List<Map<String, String>> moviesHost = [
    {"title": "Harry Potter", "poster": "assets/aven1.jpeg","description":"Phim về phù thủy"} ,
    {"title": "Avengers Endgame", "poster": "assets/aven1.jpeg","description":"Phim về siêu anh hùng"},
    {"title": "Furiosa", "poster": "assets/aven1.jpeg","description":"Phim về chiến binh"},
    {"title": "Deadpool", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ"},
    {"title": "Deadpool 2", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 2"},
    {"title": "Deadpool 3", "poster": "assets/aven1.jpeg","description":"Phim về sát thủ 3"},
  ];
  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Nhập tên phim ...',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 8),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phim hot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: moviesHost.map((movie) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  VideoCard(
                    video:VideoModel(title: movie["title"]??"no title", 
                    imageUrl: movie["poster"]??"assets/aven1.jpeg", 
                    description: movie["description"]??"no description",
                    ),
                  ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
            const SizedBox(height: 24),
            const Text(
              'Đề xuất',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true, // thêm dòng này
                physics: const BouncingScrollPhysics(), // cho smooth scroll ngang
                itemCount: moviesHost.length,
                itemBuilder: (context, index) {
                  final movie = moviesHost[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        VideoCard(
                          video:VideoModel(title: movie["title"]??"no title", 
                          imageUrl: movie["poster"]??"assets/aven1.jpeg", 
                          description: movie["description"]??"no description",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}