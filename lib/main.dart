import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/UserTrackerController.dart';
import 'package:timetracker/Screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserTrackerController())
      ],
      builder: ((context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        );
      }),
    );
  }
}
