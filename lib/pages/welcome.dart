import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quadratic_solver/locale/translations.dart';
import 'package:quadratic_solver/pages/home.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';

class Welcome extends StatelessWidget {
  Box<String> dataBox = Hive.box<String>("databox");
  @override
  //Shared Prefrences - store startup count
  Future<int> _getIntFromSharedPref() async {
    final prefs = await NativeSharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    return startupNumber ?? 0;
  }

  //Increase startupnumber
  Future<void> _incrementStartup() async {
    final prefs = await NativeSharedPreferences.getInstance();
    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;
    await prefs.setInt('startupNumber', currentStartupNumber);
    dataBox.put('Startup', '${currentStartupNumber}');
  }

  Widget build(BuildContext context) {
    _incrementStartup();
    print(dataBox.get('Startup') ?? 1);
    return int.parse(dataBox.get('Startup') ?? '1') != 1 ? Home() : Intro();
  }
}

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: Image.asset('assets/first.png'),
          title: string.text("title_welcome_first"),
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ),
          bodyWidget: Column(
            children: [
              Text(string.text("body_welcome_first"), textAlign: TextAlign.center, style: TextStyle(
                fontSize: 17
              ),),
              Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      setLanguage('vn');
                      setState(() {});
                    },
                    icon: Flag('VN'),
                  ),
                  IconButton(
                    onPressed: () {
                      setLanguage('en');
                      setState(() {});
                    },
                    icon: Flag('GB'),
                  )
                ],
              ),
            ],
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/second.png'),
          title: string.text("title_welcome_second"),
          body: string.text("body_welcome_second"),
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/third.png'),
          title: string.text("title_welcome_third"),
          body: string.text("body_welcome_third"),
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ),
        ),
      ],
      onDone: () => Navigator.pushReplacement(context, _createRoute()),
      onSkip: () => Navigator.pushReplacement(context, _createRoute()),
      showSkipButton: true,
      done: Text(string.text('Done')),
      skip: Text(string.text('Skip')),
      next: const Icon(Icons.arrow_forward),
    );
  }
}

Route _createRoute() {
  return CupertinoPageRoute(
    builder: (context) => Home(),
  );
}
