import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quadratic_solver/pages/home.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';

class Welcome extends StatelessWidget {
  Box<String> dataBox = Hive.box<String>("databox");

  @override
  //Shared Prefrences - store startup count
  Future<int> _getIntFromSharedPref() async {
    final prefs = await NativeSharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  //Increase startupnumber
  Future<void> _incrementStartup() async {
    final prefs = await NativeSharedPreferences.getInstance();
    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = 1;
    //int currentStartupNumber = ++lastStartupNumber;
    await prefs.setInt('startupNumber', currentStartupNumber);
    dataBox.put('Startup', '$currentStartupNumber');
  }

  Widget build(BuildContext context) {
    _getIntFromSharedPref();
    _incrementStartup();
    print(dataBox.get('Startup'));
    return int.parse(dataBox.get('Startup')) != 1 ? Home() : Intro();
  }
}

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: Image.asset('assets/first.png'),
          title: "Title of first page",
          body:
              "Here you can write the description of the page, to explain someting...",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/second.png'),
          title: "Title of first page",
          body:
          "Here you can write the description of the page, to explain someting...",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/third.png'),
          title: "Title of first page",
          body:
          "Here you can write the description of the page, to explain someting...",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ),
        ),
      ],
      onDone: () => Navigator.pushReplacement(context, _createRoute()),
      onSkip: () => Navigator.pushReplacement(context, _createRoute()),
      showSkipButton: true,
      done: const Text('Done'),
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
    );
  }
}

Route _createRoute() {
  return CupertinoPageRoute(
    builder: (context) => Home(),
  );
}