import 'package:movin/domain/entities/notification_entity.dart';

class NotificationDto {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool read;
  final String? screen;
  final String? entityId;
  final Map<String, dynamic>? extra;
  final DateTime createdAt;

  NotificationDto({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.read,
    this.screen,
    this.entityId,
    this.extra,
    required this.createdAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      //id: json['_id']['\$oid'] ??'',
      id: json['_id'],
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      read: json['read'] ?? false,
      screen: json['action']?['screen'],
      entityId: json['action']?['entityId'],
      extra: json['action']?['extra'],
      //: DateTime.parse(json['createdAt']),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      type: type,
      read: read,
      screen: screen,
      entityId: entityId,
      extra: extra,
      createdAt: createdAt,
    );
  }
}