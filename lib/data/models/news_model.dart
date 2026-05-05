class NewsModel {
  final String title;
  final String description;
  final String image;
  final String published;
  final String url;

  NewsModel({
    required this.title,
    required this.description,
    required this.image,
    required this.published,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      published: json['published'] ?? '',
      url: json['url'] ?? '',
    );
  }
}