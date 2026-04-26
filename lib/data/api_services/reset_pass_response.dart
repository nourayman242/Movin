import 'package:json_annotation/json_annotation.dart';

part 'reset_pass_response.g.dart';

@JsonSerializable()
class ResetPassResponse {
  final String? message;

  ResetPassResponse({this.message});

  factory ResetPassResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPassResponseToJson(this);
}