import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/notification_service.dart';
import 'package:movin/domain/entities/notification_entity.dart';
import 'package:movin/domain/repositories/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService service;

  NotificationRepositoryImpl(this.service);

  @override
  Future<List<NotificationEntity>> getAllNotifications() async {
    final result = await service.getAllNotifications();

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<NotificationEntity>> getMessages() async {
    final result = await service.getMessages();

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<NotificationEntity>> getAlerts() async {
    final result = await service.getAlerts();

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> markAsRead(String id) async {
    await service.markAsRead(id);
  }

  @override
  Future<void> markAllAsRead() async {
    await service.markAllAsRead();
  }
}