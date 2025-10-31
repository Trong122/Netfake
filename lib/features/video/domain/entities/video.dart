class Video{
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final double rating; // Average rating out of 5

  const Video({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.rating,
  });
}