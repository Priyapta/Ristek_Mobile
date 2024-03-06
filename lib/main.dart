import 'package:flutter/material.dart';
import 'package:flutter_todolist/pages/home.dart';
import 'package:flutter_todolist/pages/profile.dart';
// import 'package:flutter_todolist/pages/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialze hive
  await Hive.initFlutter();

  // open box
  var box = await Hive.openBox('mybox');

  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}
