class ErrorModel {
  //understand the response of error from api and display it to the user
  final int? statusCode;
  final String? message;

  ErrorModel({
    this.statusCode,
    this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
