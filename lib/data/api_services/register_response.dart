
import 'package:json_annotation/json_annotation.dart';
import 'user_response.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String message;


  RegisterResponse({
    required this.message,

  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
