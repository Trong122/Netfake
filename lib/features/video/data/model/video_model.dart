import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/video.dart';

class VideoModel extends Video {
  const VideoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.videoUrl,
    required super.rating,
  });

  factory VideoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VideoModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      rating: (data['rating'] as num? ?? 0.0).toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'videoUrl': videoUrl,
    'rating': rating,
  };
  factory VideoModel.fromEntity(Video video) {
    return VideoModel(
      id: video.id,
      title: video.title,
      description: video.description,
      imageUrl: video.imageUrl,
      videoUrl: video.videoUrl,
      rating: video.rating,
    );
  }
   factory VideoModel.fromMap(Map<String, dynamic> data) {
    return VideoModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      rating: (data['rating'] as num? ?? 0.0).toDouble(),
    );
  }

}
