import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const VideoDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SvgPicture.asset('assets/Logo.svg', width: 40, height: 40),
            // SizedBox(width: 40, height: 40, child: Placeholder()),
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
            // Poster phim + tiêu đề
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageUrl,
                    width: 120,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                // Thông tin phim
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "2001 | Anh, Âu Mỹ | Phim viễn tưởng",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(onPressed: (){}, 
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text("Xem Phim")),
                          ),
                           IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite, color: Colors.white),
                           )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Nội dung phim
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(description,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),

            // Bình luận
            const Text(
              "0 bình luận",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Bình luận...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
