// models/photo.dart
class Photo {
  final String id;
  final String imageUrl;
  final String caption;
  String description;
  final bool isFavorite;

  Photo({
    required this.id,
    required this.imageUrl,
    required this.caption,
    required this.description,
    required this.isFavorite,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id']?.toString() ?? '',
      imageUrl: json['url'] ?? '',
      caption: json['title'] ?? '',
      description: json['description'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': imageUrl,
        'title': caption,
        'description': description,
        'is_favorite': isFavorite,
      };
}
