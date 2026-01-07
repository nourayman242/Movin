import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/domain/entities/notification_item.dart';
import 'package:movin/presentation/notifications/widgets/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late List<NotificationItem> items;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    items = sampleNotifications
        .map(
          (e) => NotificationItem(
            id: e.id,
            title: e.title,
            body: e.body,
            createdAt: e.createdAt,
            type: e.type,
            read: e.read,
          ),
        )
        .toList();

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      // rebuild when tab changes
      if (!tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void markAllRead() {
    setState(() {
      for (var n in items) n.read = true;
    });
  }

  void markRead(NotificationItem n) {
    setState(() {
      final idx = items.indexWhere((x) => x.id == n.id);
      if (idx != -1) items[idx].read = true;
    });
  }

  List<NotificationItem> get filteredItems {
    switch (tabController.index) {
      case 1:
        return items.where((n) => n.type == "message").toList();
      case 2:
        return items.where((n) => n.type == "alert").toList();
      default:
        return items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: markAllRead,
            child: Text(
              'Mark all as read',
              style: TextStyle(color: AppColors.gold),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _buildTabs(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 400));
                },
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _buildList(items),
                    _buildList(
                      items.where((n) => n.type == 'message').toList(),
                    ),
                    _buildList(items.where((n) => n.type == 'alert').toList()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<NotificationItem> list) {
    if (list.isEmpty) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Center(
            child: Text('No notifications', style: AppTextStyles.subHeading),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final n = list[index];
        return NotificationCard(notification: n, onTap: () => markRead(n));
      },
    );
  }

  // Tabs
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        labelColor: AppColors.primaryNavy,
        unselectedLabelColor: Colors.grey,
        indicator: BoxDecoration(
          // color: AppColors.background,
          // borderRadius: BorderRadius.circular(20),
        ),
        //indicatorSize: TabBarIndicatorSize.label,

        // BoxDecoration(
        //   color: Colors.transparent,
        //   //AppColors.white,
        //   borderRadius: BorderRadius.circular(30),
        // ),
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Messages'),
          Tab(text: 'Alerts'),
        ],
      ),
    );
  }
}
