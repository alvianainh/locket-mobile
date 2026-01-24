class Photo {
  final String id;
  final String imageUrl;
  final String caption;

  Photo({
    required this.id,
    required this.imageUrl,
    required this.caption,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      imageUrl: json['image_url'],
      caption: json['caption'],
    );
  }
}
