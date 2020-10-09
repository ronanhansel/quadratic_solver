import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:quadratic_solver/pages/result.dart';
import 'package:quadratic_solver/services/admob_services.dart';
import 'package:quadratic_solver/translations/translation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    dataBox = Hive.box<String>("databox");
    Admob.initialize();
    super.initState();
  }

  Box<String> dataBox;
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final thirdController = TextEditingController();
  final ams = AdMobService();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Input',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                          string.text("user_input_sub"),
                          style: TextStyle(fontSize: 17)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Divider(
                          color: Colors.white,
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          child: TextField(
                            autocorrect: false,
                            controller: firstController,
                            decoration: InputDecoration(
                                labelText: 'a',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                )),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: false),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9-.]")),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          child: TextField(
                            autocorrect: false,
                            controller: secondController,
                            decoration: InputDecoration(
                                labelText: 'b',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                )),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: false),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9-.]")),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          child: TextField(
                            autocorrect: false,
                            controller: thirdController,
                            decoration: InputDecoration(
                                labelText: 'c',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                )),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: false),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9-.]")),
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
              SizedBox(
                height: 20,
              ),
              AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (firstController.text == '') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Please fill all the required values'),
                  );
                });
          } else if (firstController.text == '0') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('a can\'t be 0'),
                  );
                });
          } else if (secondController.text == '') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('Please fill all the required values'));
                });
          } else if (thirdController.text == '') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Please fill all the required values'),
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
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => Result()));
          }
        },
        child: Hero(
          tag: 'fab',
          child: Container(
            width: 60,
            height: 60,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              color: Colors.grey[100],
              child: Center(
                  child: Text('=',
                      style: TextStyle(fontSize: 30, color: Colors.black))),
            ),
          ),
        ),
      ),
    );
  }
}
