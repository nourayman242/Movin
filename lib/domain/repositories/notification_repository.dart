import 'package:movin/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getAllNotifications();

  Future<List<NotificationEntity>> getMessages();

  Future<List<NotificationEntity>> getAlerts();

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead();
}