class Photo {
  final String id;
  final String url;
  final String downloadUrl;

  Photo({
    required this.id,
    required this.url,
    required this.downloadUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['urls']['regular'],
      downloadUrl: json['links']['download'],
    );
  }
}