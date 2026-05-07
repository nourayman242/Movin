class ResendOtpResponse {
  final String message;

  ResendOtpResponse({
    required this.message,
  });

  factory ResendOtpResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return ResendOtpResponse(
      message: json['message'] ?? '',
    );
  }
}