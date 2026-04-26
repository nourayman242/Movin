// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: UserResponse._phoneFromJson(json['phone']),
      isSeller: json['isSeller'] as bool,
      isBuyer: json['isBuyer'] as bool,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'isSeller': instance.isSeller,
      'isBuyer': instance.isBuyer,
      'isAdmin': instance.isAdmin,
    };
