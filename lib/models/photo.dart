//models/photo.dart
class Photo {
  final String id;
  final String imageUrl;
  final String caption;
  String description;

  Photo({
    required this.id,
    required this.imageUrl,
    required this.caption,
    this.description = '',
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      imageUrl: json['image_url'],
      caption: json['caption'],
      description: json['description'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': imageUrl,
        'caption': caption,
        'description': description,
      };
}
