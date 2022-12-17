import 'package:flutter/material.dart';
import 'package:pillreminder/provider/pill_provider.dart';
import 'package:pillreminder/provider/pilldate_provider.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PillProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PillDateProvider(),
          )
        ],
        child: const MaterialApp(
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
          home: MyHomePage(),
        ));
  }
}
