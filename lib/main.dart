import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quadratic_solver/pages/home.dart';
import 'package:quadratic_solver/pages/result.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox<String>("databox");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quadratic Solver',
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/result': (context) => Result(),
      },
    ));
  });
}
