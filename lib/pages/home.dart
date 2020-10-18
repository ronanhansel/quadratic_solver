import 'package:admob_flutter/admob_flutter.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:quadratic_solver/pages/result.dart';
import 'package:quadratic_solver/services/admob_services.dart';
import 'package:quadratic_solver/locale/translations.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'dart:async';

import 'package:quadratic_solver/widgets/alerts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Intro intro = Intro(
    stepCount: 3,
    padding: EdgeInsets.all(8),
    borderRadius: BorderRadius.all(Radius.circular(4)),
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        string.text('guide_first'),
        string.text('guide_second'),
        string.text('guide_third'),
      ],
      btnLabel: string.text('Next'),
      showStepLabel: true,
    ),
  );
  final ams = AdMobService();

  @override
  void initState() {
    dataBox = Hive.box<String>("databox");
    if (dataBox.get("Startup") == '1') {
      Timer(Duration(microseconds: 0), () {
        intro.start(context);
      });
    }
    super.initState();
  }

  Box<String> dataBox;
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final thirdController = TextEditingController();
  String a = 'a';
  String b = 'b';
  String c = 'c';

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    key: intro.keys[0],
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
                      ),
                      IconButton(
                        icon: Icon(Icons.help_outline),
                        onPressed: () {
                          Timer(Duration(microseconds: 0), () {
                            intro.start(context);
                          });
                        },
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        string.text('user_input'),
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        child: Text(string.text('user_input_sub'),
                            style: TextStyle(fontSize: 17)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                     Column(
                       children: [
                         Center(
                           child: Text(
                             '$a' + 'x\u00B2 + ' + '$b' + 'x + ' + '$c' + ' = 0',
                             style: TextStyle(fontSize: 30),
                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Row(
                           key: intro.keys[1],
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Divider(
                               color: Colors.white,
                               height: 10,
                             ),
                             Expanded(
                               flex: 1,
                               child: TextField(
                                 autocorrect: false,
                                 controller: firstController,
                                 onChanged: (text) {
                                   setState(() {
                                     a = text;
                                   });
                                 },
                                 decoration: InputDecoration(
                                     labelText: 'a',
                                     labelStyle: TextStyle(
                                       color: Colors.red,
                                       fontSize: 30,
                                     )),
                                 keyboardType: TextInputType.numberWithOptions(
                                     decimal: false),
                                 inputFormatters: <TextInputFormatter>[
                                   FilteringTextInputFormatter.allow(
                                       RegExp("[0-9-.]")),
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 10,
                             ),
                             Expanded(
                               flex: 1,
                               child: TextField(
                                 autocorrect: false,
                                 controller: secondController,
                                 onChanged: (text) {
                                   setState(() {
                                     b = text;
                                   });
                                 },
                                 decoration: InputDecoration(
                                     labelText: 'b',
                                     labelStyle: TextStyle(
                                       color: Colors.red,
                                       fontSize: 30,
                                     )),
                                 keyboardType: TextInputType.numberWithOptions(
                                     decimal: false),
                                 inputFormatters: <TextInputFormatter>[
                                   FilteringTextInputFormatter.allow(
                                       RegExp("[0-9-.]")),
                                 ],
                               ),
                             ),
                             SizedBox(
                               width: 10,
                             ),
                             Expanded(
                               flex: 1,
                               child: TextField(
                                 autocorrect: false,
                                 controller: thirdController,
                                 onChanged: (text) {
                                   setState(() {
                                     c = text;
                                   });
                                 },
                                 decoration: InputDecoration(
                                     labelText: 'c',
                                     labelStyle: TextStyle(
                                       color: Colors.red,
                                       fontSize: 30,
                                     )),
                                 keyboardType: TextInputType.numberWithOptions(
                                     decimal: false),
                                 inputFormatters: <TextInputFormatter>[
                                   FilteringTextInputFormatter.allow(
                                       RegExp("[0-9-.]")),
                                 ],
                               ),
                             ),
                           ],
                         ),
                         SizedBox(
                           height: MediaQuery.of(context).size.height / 8,
                         ),
                         ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: AdmobBanner(
                               adUnitId: ams.getBannerAdId(),
                               adSize: AdmobBannerSize.BANNER),
                         ),
                       ],
                     )
                    ],
                  ),

                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    key: intro.keys[2],
                    height: 50,
                    width: 50,
                    child: NeuButton(
                      child: Center(
                          child: Text(
                        '=',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                      decoration: NeumorphicDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () {
                        if (firstController.text == '') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Alert(
                                    warning:
                                        string.text('empty_values_warning'));
                              });
                        } else if (firstController.text == '0') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Alert(
                                  warning: string.text('a_zero'),
                                );
                              });
                        } else if (secondController.text == '') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Alert(
                                  warning: 'empty_values_warning',
                                );
                              });
                        } else if (thirdController.text == '') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Alert(
                                  warning: 'empty_values_warning',
                                );
                              });
                        } else {
                          dataBox.put("data1", firstController.text);
                          dataBox.put(
                            "data2",
                            secondController.text,
                          );
                          dataBox.put(
                            "data3",
                            thirdController.text,
                          );
                          Navigator.of(context).push(_createRoute());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> setLanguage(String code) async {
  await string.setNewLanguage(code).then((_) {
    string.setPreferredLanguage(string.currentLanguage);
  });
}

Route _createRoute() {
  return CupertinoPageRoute(
    builder: (context) => Result(),
  );
}
