abstract class NotificationEvent {}

class GetAllNotificationsEvent extends NotificationEvent {}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String id;

  MarkNotificationAsReadEvent(this.id);
}

class MarkAllNotificationsAsReadEvent extends NotificationEvent {}