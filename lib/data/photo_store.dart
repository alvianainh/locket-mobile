//data/photo_store.dart
import '../models/photo.dart';

class PhotoStore {
  static final List<Photo> _photos = [];

  static List<Photo> get photos => _photos;

  static void addPhoto({
    required String imageUrl,
    required String caption,
  }) {
    _photos.insert(
      0,
      Photo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: imageUrl,
        caption: caption,
        description: '',    
        isFavorite: false,  
      ),
    );
  }
}
