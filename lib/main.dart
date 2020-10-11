import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quadratic_solver/pages/home.dart';
import 'package:quadratic_solver/pages/result.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quadratic_solver/locale/translations.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox<String>("databox");
  await GetStorage.init();
  await string.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: string.supportedLocales(),
      title: 'Quadratic Solver',
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/result': (context) => Result(),
      },
    ));
  });
}
