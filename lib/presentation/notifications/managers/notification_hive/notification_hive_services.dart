import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/notification_entity.dart';

import 'notification_hive_model.dart';

@lazySingleton
class NotificationHiveService {
  static const String boxName = 'notifications_box';

  Future<void> init() async {
    Hive.registerAdapter(NotificationHiveModelAdapter());

    await Hive.openBox<NotificationHiveModel>(boxName);
  }

  Box<NotificationHiveModel> get box =>
      Hive.box<NotificationHiveModel>(boxName);

  Future<void> cacheNotifications(
      List<NotificationEntity> notifications,
      ) async {
    await box.clear();

    for (final item in notifications) {
      await box.put(
        item.id,
        NotificationHiveModel(
          id: item.id,
          title: item.title,
          body: item.body,
          type: item.type,
          read: item.read,
          createdAt: item.createdAt,
        ),
      );
    }
  }

  List<NotificationEntity> getNotifications() {
    return box.values.map((e) {
      return NotificationEntity(
        id: e.id,
        title: e.title,
        body: e.body,
        type: e.type,
        read: e.read,
        createdAt: e.createdAt,
      );
    }).toList();
  }
}