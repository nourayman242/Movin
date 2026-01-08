import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/notification_item.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback? onTap;

  const NotificationCard({
    Key? key,
    required this.notification,
    this.onTap,
  }) : super(key: key);

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
              _buildIcon(notification.type),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.title, style: AppTextStyles.label),
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
              const SizedBox(width: 8),
              // unread dot: show only when notification.read == false
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

  Widget _buildIcon(String type) {
    IconData icon;
    Color bg;

    switch (type) {
      case 'message':
        icon = Icons.chat_bubble_outline;
        bg = Colors.blue.shade50;
        break;
      case 'alert':
        icon = Icons.gavel;
        bg = Colors.orange.shade50;
        break;
      case 'promo':
      default:
        icon = Icons.favorite_border;
        bg = Colors.pink.shade50;
    }

    return CircleAvatar(
      backgroundColor: bg,
      radius: 22,
      child: Icon(icon, color: AppColors.primaryNavy),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
  }
}
