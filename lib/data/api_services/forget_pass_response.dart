// lib/data/models/forget_pass_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'forget_pass_response.g.dart';

@JsonSerializable()
class ForgetPassResponse {
  final String message;

  ForgetPassResponse({required this.message});

  factory ForgetPassResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPassResponseFromJson(json);
}
