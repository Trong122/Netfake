import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable{
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final double rating; // Average rating out of 5

  VideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        videoUrl,
        rating,
      ];
}