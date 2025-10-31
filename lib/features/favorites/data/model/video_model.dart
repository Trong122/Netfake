import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/favorites_video.dart';
import '../../../video/data/model/video_model.dart'; // để map Video

class FavoritesVideoModel extends FavoritesVideo {
  const FavoritesVideoModel({
    required super.userId,
    required super.video,
  });

  // Lấy từ DocumentSnapshot của FavoritesVideo
  factory FavoritesVideoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Document ${doc.id} is null");
    }

    final videoData = data['video'] as Map<String, dynamic>?;
    if (videoData == null) {
      throw Exception("Video field is null in document ${doc.id}");
    }

    return FavoritesVideoModel(
      userId: data['userId'] ?? '',
      video: VideoModel.fromMap(videoData), // Dùng fromMap cho nested video
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'video': (video as VideoModel).toJson(), // chuyển Video thành Map
      };

  factory FavoritesVideoModel.fromEntity(FavoritesVideo fav) {
    return FavoritesVideoModel(
      userId: fav.userId,
      video: fav.video,
    );
  }

  FavoritesVideo toEntity() {
    return FavoritesVideo(
      userId: userId,
      video: video,
    );
  }
}
