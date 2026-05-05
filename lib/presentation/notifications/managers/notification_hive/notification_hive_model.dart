import 'package:hive/hive.dart';

part 'notification_hive_model.g.dart';

@HiveType(typeId: 7)
class NotificationHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  @HiveField(3)
  String type;

  @HiveField(4)
  bool read;

  @HiveField(5)
  DateTime createdAt;

  NotificationHiveModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.read,
    required this.createdAt,
  });
}