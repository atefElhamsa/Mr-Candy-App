import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;
    const initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "Daily Id Channel",
        "Daily Notification Channel",
        channelDescription: "Daily Description Channel",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  Future<void> saveNotifications({
    String? title,
    String? body,
    int id = 0,
  }) async {
    showNotification(
      title: title,
      body: body,
      id: id,
    );
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    final notificationData = '$title|$body|$id';
    notifications.add(notificationData);
    await prefs.setStringList('notifications', notifications);
  }

  Future<void> deleteNotifications({required int index}) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
      await prefs.setStringList('notifications', notifications);
    }
  }

  Future<void> deleteAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
  }

  Future<List<Map<String, String>>> getSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    return notifications.map((item) {
      final parts = item.split('|');
      return {
        'title': parts[0],
        'body': parts[1],
        'id': parts[2],
      };
    }).toList();
  }
}
