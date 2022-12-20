import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pillreminder/pages/homepage.dart';
import 'package:workmanager/workmanager.dart';

import './pages/home.dart';
import 'homewidget.dart';

void main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  // // Periodic task registration
  // Workmanager().registerPeriodicTask(
  //   "2",

  //   //This is the value that will be
  //   // returned in the callbackDispatcher
  //   "simplePeriodicTask",

  //   // When no frequency is provided
  //   // the default 15 minutes is set.
  //   // Minimum frequency is 15 min.
  //   // Android will automatically change
  //   // your frequency to 15 min
  //   // if you have configured a lower frequency.
  //   frequency: const Duration(seconds: 5),
  // );

  runApp(const MyApp());
}

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     // initialise the plugin of flutterlocalnotifications.
//     FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

//     // app_icon needs to be a added as a drawable
//     // resource to the Android head project.
//     var android = const AndroidInitializationSettings('@mipmap/ic_launcher');

//     // initialise settings for both Android and iOS device.
//     var settings = InitializationSettings(android: android);
//     flip.initialize(settings);
//     _showNotificationWithDefaultSound(flip);
//     return Future.value(true);
//   });
// }

// Future _showNotificationWithDefaultSound(flip) async {
//   // Show a notification after every 15 minute with the first
//   // appearance happening a minute after invoking the method
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your channel id', 'your channel name',
//       importance: Importance.max, priority: Priority.high);

//   // initialise channel platform for both Android and iOS device.
//   var platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flip.show(
//       0,
//       'GeeksforGeeks',
//       'Your are one step away to connect with GeeksforGeeks',
//       platformChannelSpecifics,
//       payload: 'Default_Sound');
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('th'),
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // home: MyWidget2(),
      home: MyWidget(),
    );
  }
}
