import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class AppNotification {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final bool isRead;
  @HiveField(5)
  final String type;
  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    required this.type,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);
}
