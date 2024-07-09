// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilive/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');
  await Hive.openBox("Habit_Database");
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hilive',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
