import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Initialize the plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Set up the notification settings
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    // Display the notification
    await flutterLocalNotificationsPlugin.show(
      0, // notification ID
      title, // notification title
      body, // notification body
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
    );
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDateTime) async {
    // Schedule the notification to be displayed at the specified time
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0, // notification ID
      title, // notification title
      body, // notification body
      scheduledDateTime,
      platformChannelSpecifics,
    );
  }
}
