import '../../features/video/domain/entities/video_entity.dart';

class VideoModel{
  final String title;
  final String? id;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final double? rating; // Average rating out of 5

  VideoModel({
    required this.title,
    this.imageUrl,
    this.description,
    this.id,
    this.videoUrl,
    this.rating,
  });
  factory VideoModel.fromEntityHome(VideoEntity entity) {
    return VideoModel(
      title: entity.title,
      imageUrl: entity.imageUrl,
      description: entity.description,
    );
  }
  factory VideoModel.fromEntityWithRating(VideoEntity entity) {
  return VideoModel(
    title: entity.title,
    rating: entity.rating,
  );
}
  // factory VideoModel.fromJson(Map<String, dynamic> json) {
  //   return VideoModel(
  //     title: json['title'],
  //     imageUrl: json['thumbnailUrl'],
  //     description: json['description'],
  //   );
  // }
}
