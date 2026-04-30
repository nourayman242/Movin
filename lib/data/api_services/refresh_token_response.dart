class RefreshTokenResponse {
  final String accessToken;
  final String refreshToken;

  RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    final data = json["accessToken"]; // nested object
    return RefreshTokenResponse(
      accessToken: data["accessToken"] ?? "",
      refreshToken: data["refreshToken"] ?? "",
    );
  }
}