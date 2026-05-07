import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/notification_entity.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLarge = width > 600;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLarge ? 24 : 16,
            vertical: isLarge ? 20 : 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(notification),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: AppTextStyles.label,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      notification.body,
                      style: AppTextStyles.smallText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _timeAgo(notification.createdAt),
                      style: AppTextStyles.smallText,
                    ),
                  ],
                ),
              ),

              if (!notification.read)
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: AppColors.gold,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildIcon(String type) {
  //   IconData icon;
  //   Color bg;
  //
  //   switch (type) {
  //     case 'message':
  //       icon = Icons.chat_bubble_outline;
  //       bg = Colors.blue.shade50;
  //       break;
  //
  //     case 'alert':
  //       //icon = Icons.gavel;
  //       icon = Icons.notifications_none;
  //
  //       bg = Colors.orange.shade50;
  //       break;
  //
  //     default:
  //       //icon = Icons.notifications_none;
  //       icon = Icons.gavel;
  //       bg = Colors.grey.shade100;
  //   }

  //   return CircleAvatar(
  //     backgroundColor: bg,
  //     radius: 22,
  //     child: Icon(
  //       icon,
  //       color: AppColors.primaryNavy,
  //     ),
  //   );
  // }
  Widget _buildIcon(NotificationEntity notification) {
    final title = notification.title.toLowerCase();
    final body = notification.body.toLowerCase();

    IconData icon;
    Color bg;

    if (notification.type == 'message') {
      icon = Icons.chat_bubble_outline;
      bg = Colors.blue.shade50;
    }

    else if (
    title.contains('auction') ||
        body.contains('auction') ||
        body.contains('bid')
    ) {
      icon = Icons.gavel;
      bg = Colors.orange.shade50;
    }

    else if (
    title.contains('price') ||
        body.contains('price') ||
        body.contains('reduced')
    ) {
      icon = Icons.attach_money;
      bg = Colors.green.shade50;
    }

    else if (
    title.contains('favorite') ||
        title.contains('wishlist')
    ) {
      icon = Icons.favorite_border;
      bg = Colors.pink.shade50;
    }

    else if (
    title.contains('property') ||
        body.contains('villa') ||
        body.contains('apartment')
    ) {
      icon = Icons.home_outlined;
      bg = Colors.purple.shade50;
    }

    else {
      icon = Icons.notifications_none;
      bg = Colors.grey.shade100;
    }

    return CircleAvatar(
      backgroundColor: bg,
      radius: 22,
      child: Icon(
        icon,
        color: AppColors.primaryNavy,
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    }

    if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    }

    return '${diff.inDays} days ago';
  }
}