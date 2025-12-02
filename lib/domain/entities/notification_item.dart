class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String type; 
  bool read;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.type = 'alert',
    this.read = false,
  });
}

final List<NotificationItem> sampleNotifications = [
  NotificationItem(
    id: '1',
    title: 'New message from John Smith',
    body: 'Interested in your Modern Luxury Villa listing',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    type: 'message',
    read: false,
  ),
  NotificationItem(
    id: '2',
    title: 'Auction Starting Soon',
    body: 'Palm Jumeirah Villa auction starts in 2 hours',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    type: 'alert',
    read: false,
  ),
  NotificationItem(
    id: '3',
    title: 'Price Drop Alert',
    body: 'Contemporary Villa price reduced by 10%',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    type: 'promo',
    read: false,
  ),
  NotificationItem(
    id: '4',
    title: 'Property Added to Favorites',
    body: 'Your listing was added to 5 wishlists today',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    type: 'promo',
    read: true,
  ),
  NotificationItem(
    id: '5',
    title: 'New Property in Your Area',
    body: 'Luxury Penthouse in Dubai Marina just listed',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    type: 'alert',
    read: true,
  ),
];
