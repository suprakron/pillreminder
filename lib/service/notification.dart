import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class NotificationService {
  // Initialize the plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // NotificationService() {
  //   // Initialize the plugin
  //   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   // Set up the initialization settings
  //   var initializationSettingsAndroid =
  //       const AndroidInitializationSettings('app_icon');
  //   var initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //   // Set up the background task
  //   Workmanager().initialize(callbackDispatcher);
  //   Workmanager().registerPeriodicTask(
  //     "1",
  //     "sendNotificationTask",
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     frequency: const Duration(hours: 1),
  //   );
  // }

  // // Set up the notification details
  // NotificationDetails platformChannelSpecifics = const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //         'your channel id', 'your channel name',
  //         importance: Importance.max, priority: Priority.high));

  // void callbackDispatcher() {
  //   Workmanager().executeTask((task, inputData) async {
  //     // Check the input data to determine which notification to schedule
  //     if (inputData!['notificationId'] == '1') {
  //       await flutterLocalNotificationsPlugin.show(0, 'Notification Title 1',
  //           'Notification Body 1', platformChannelSpecifics);
  //     } else if (inputData['notificationId'] == '2') {
  //       await flutterLocalNotificationsPlugin.show(1, 'Notification Title 2',
  //           'Notification Body 2', platformChannelSpecifics);
  //     }

  //     return Future.value(true);
  //   });
  // }

  Future<void> init() async {
    // Set up the notification settings
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
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
