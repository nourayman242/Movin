class FavoriteResponse {
  final String message; 
  final List<String> favorites; 

  FavoriteResponse({required this.message, required this.favorites});

  factory FavoriteResponse.fromMap(Map<String, dynamic> map) {
    return FavoriteResponse(
      message: map['message'] ?? '',
      favorites: map['favorites'] != null
          ? List<String>.from(map['favorites'])
          : [],
    );
  }
}