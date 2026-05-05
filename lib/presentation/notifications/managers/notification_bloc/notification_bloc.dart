import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/notification_entity.dart';
import 'package:movin/domain/repositories/notification_repository.dart';

import '../notification_hive/notification_hive_services.dart';
import 'notification_event.dart';
import 'notification_state.dart';

@injectable
class NotificationBloc
    extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repo;
  final NotificationHiveService hive;

  List<NotificationEntity> allNotifications = [];

  NotificationBloc(this.repo, this.hive)
      : super(NotificationInitial()) {
    on<GetAllNotificationsEvent>(_getAllNotifications);

    on<MarkNotificationAsReadEvent>(_markAsRead);

    on<MarkAllNotificationsAsReadEvent>(_markAllAsRead);
  }

  Future<void> _getAllNotifications(
      GetAllNotificationsEvent event,
      Emitter<NotificationState> emit,
      ) async {
    emit(NotificationLoading());

    try {
      final result = await repo.getAllNotifications();

      allNotifications = result;

      await hive.cacheNotifications(result);

      emit(NotificationLoaded(result));
    } catch (e) {
      final cached = hive.getNotifications();

      if (cached.isNotEmpty) {
        allNotifications = cached;

        emit(NotificationLoaded(cached));
      } else {
        emit(NotificationError(e.toString()));
      }
    }
  }

  Future<void> _markAsRead(
      MarkNotificationAsReadEvent event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await repo.markAsRead(event.id);

      allNotifications = allNotifications.map((e) {
        if (e.id == event.id) {
          return e.copyWith(read: true);
        }

        return e;
      }).toList();

      await hive.cacheNotifications(allNotifications);

      emit(NotificationLoaded(allNotifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _markAllAsRead(
      MarkAllNotificationsAsReadEvent event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await repo.markAllAsRead();

      allNotifications = allNotifications.map((e) {
        return e.copyWith(read: true);
      }).toList();

      await hive.cacheNotifications(allNotifications);

      emit(NotificationLoaded(allNotifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}