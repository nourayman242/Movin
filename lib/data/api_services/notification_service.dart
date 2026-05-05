import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/notification_model.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationService {
  factory NotificationService(Dio dio, {String baseUrl}) =
  _NotificationService;

  @GET('/api/notifications/all')
  Future<List<NotificationDto>> getAllNotifications();

  @GET('/api/notifications/messages')
  Future<List<NotificationDto>> getMessages();

  @GET('/api/notifications/alerts')
  Future<List<NotificationDto>> getAlerts();

  @PATCH('/api/notifications/{id}/read')
  Future<void> markAsRead(
      @Path('id') String id,
      );

  @PATCH('/api/notifications/read-all')
  Future<void> markAllAsRead();
}