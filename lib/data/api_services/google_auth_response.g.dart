// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleAuthResponse _$GoogleAuthResponseFromJson(Map<String, dynamic> json) =>
    GoogleAuthResponse(
      token: json['token'] as String,
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleAuthResponseToJson(GoogleAuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
