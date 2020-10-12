import 'dart:math';
import 'package:catex/catex.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quadratic_solver/locale/translations.dart';
import 'package:quadratic_solver/services/hints.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:hive/hive.dart';
import 'package:quadratic_solver/services/admob_services.dart';
import 'package:admob_flutter/admob_flutter.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> with TickerProviderStateMixin {
  int round = 8;
  int decimal;
  final ams = AdMobService();

  @override
  void initState() {
    dataBox = Hive.box<String>("databox");
    Admob.requestTrackingAuthorization();
    Admob.initialize();
    super.initState();
  }

  int d;
  bool deltaint = false;
  Box<String> dataBox;

  Widget build(BuildContext context) {
    bool validity = true;
    double aa = double.parse(dataBox.get("data1"));
    double bb = double.parse(dataBox.get("data2"));
    double cc = double.parse(dataBox.get("data3"));
    double minusbb = -bb;
    if (round == 3) {
      decimal = 8;
    } else {
      decimal = 3;
    }
    var a;
    var b;
    var c;
    var minusb;
    if (aa * 10 - (aa.toInt()) * 10 == 0) {
      a = aa.toInt();
    } else if (aa * 10 - (aa.toInt()) * 10 != 0) {
      a = aa;
    }
    if (bb * 10 - (bb.toInt()) * 10 == 0) {
      b = bb.toInt();
    } else if (bb * 10 - (bb.toInt()) * 10 != 0) {
      b = bb;
    }
    if (cc * 10 - (cc.toInt()) * 10 == 0) {
      c = cc.toInt();
    } else if (cc * 10 - (cc.toInt()) * 10 != 0) {
      c = cc;
    }
    if (minusbb * 10 - (minusbb.toInt()) * 10 == 0) {
      minusb = minusbb.toInt();
    } else if (minusbb * 10 - (minusbb.toInt()) * 10 != 0) {
      minusb = minusbb;
    }
    String buttoncontent = 'Round up to $decimal decimal number?';
    var deltaa = b * b - 4 * a * c;
    var delta;
    if (deltaa * 10 - (deltaa.toInt()) * 10 == 0 && validity) {
      delta = deltaa.toInt();
      deltaint = true;
    } else {
      String deltaString = deltaa.toStringAsFixed(5);
      delta = double.parse(deltaString);
    }

    double xonee = ((-b) + sqrt(delta)) / (2 * a);
    var xone;
    if (!xonee.isNaN) {
      if (xonee * 10 - (xonee.toInt()) * 10 == 0) {
        xone = xonee.toInt();
      } else if (xonee * 10 - (xonee.toInt()) * 10 != 0) {
        xone = xonee;
      }
    } else if (xonee.isNaN) {
      xone = xonee;
    }
    double num11 = double.parse((xone).toStringAsFixed(round));
    var num1;
    if (!num11.isNaN) {
      if (num11 * 10 - (num11.toInt()) * 10 == 0) {
        num1 = num11.toInt();
      } else if (num11 * 10 - (num11.toInt()) * 10 != 0) {
        num1 = num11;
      }
    } else if (num11.isNaN) {
      num1 = num11;
    }
    double xtwoo = ((-b) - sqrt(delta)) / (2 * a);
    var xtwo;
    if (!xtwoo.isNaN) {
      if (xtwoo * 10 - (xtwoo.toInt()) * 10 == 0) {
        xtwo = xtwoo.toInt();
      } else if (xtwoo * 10 - (xtwoo.toInt()) * 10 != 0) {
        xtwo = xtwoo;
      }
    } else if (xtwoo.isNaN) {
      xtwo = xtwoo;
    }
    double num22 = double.parse((xtwo).toStringAsFixed(round));
    var num2;
    if (!num22.isNaN) {
      if (num22 * 10 - (num22.toInt()) * 10 == 0) {
        num2 = num22.toInt();
      } else if (num22 * 10 - (num22.toInt()) * 10 != 0) {
        num2 = num22;
      }
    } else if (num11.isNaN) {
      num2 = num22;
    }
    String xtworesult = '\\frac {$minusb - \\sqrt {$delta}}  {2 * $a}';
    String xoneresult = '\\frac {$minusb + \\sqrt {$delta}}  {2 * $a}';
    if (delta < 0) {
      validity = false;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SlidingUpPanel(
        backdropColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Wrap(
            children: <Widget>[
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            string.text('result'),
                            style: TextStyle(
                                fontSize: 45, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    DefaultTextStyle.merge(
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      child: Text('${a}x\u00B2 + ${b}x + $c = 0'),
                    ),
                  ],
                ),
              ),
              Divider(height: 25, color: Colors.grey[100]),
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      string.text('delta_is') + '$delta',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
              Text(
                () {
                  if (!validity) {
                    return string.text('no_real');
                  } else {
                    return string.text('has_real');
                  }
                }(),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.red[900],
                    fontStyle: FontStyle.italic),
              ),
              Divider(height: 20, color: Colors.grey[100]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(fontSize: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                alignment: WrapAlignment.center,
                                children: [
                                  Text('x\u2081 ' + string.text('plus_is')),
                                  CaTeX(
                                      '\\frac {-b + \\sqrt {\u0394}}  {2 * a}'),
                                  DefaultTextStyle.merge(
                                      style: TextStyle(fontSize: 20),
                                      child: Row(
                                        children: [
                                          Text('= '),
                                          CaTeX(xoneresult),
                                        ],
                                      )),
                                  Text(
                                    '= $num1',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                alignment: WrapAlignment.center,
                                children: [
                                  Text('x\u2082 ' + string.text('minus_is')),
                                  CaTeX(
                                      '\\frac {-b - \\sqrt {\u0394}}  {2 * a}'),
                                  DefaultTextStyle.merge(
                                      style: TextStyle(fontSize: 20),
                                      child: Row(
                                        children: [
                                          Text('= '),
                                          CaTeX(xtworesult),
                                        ],
                                      )),
                                  Text(
                                    '= $num2',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 20, color: Colors.grey[100]),
              FutureBuilder(builder:
                  (BuildContext context, AsyncSnapshot<Widget> widget) {
                if (validity && !deltaint) {
                  return Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: RaisedButton(
                      child: Text(
                        '$buttoncontent',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      elevation: 0,
                      onPressed: () {
                        setState(() {
                          if (round == 8) {
                            round = 3;
                          } else {
                            round = 8;
                          }
                        });
                      },
                    ),
                  ));
                }
                return Container(
                  child: widget.data,
                  width: 0,
                  height: 0,
                );
              }),
              Center(child: AdmobBanner(adUnitId: ams.getBannerAdId(), adSize: AdmobBannerSize.BANNER))
            ],
          ),
        ),
        panel: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          height: 25,
                          width: 25,
                          child: FlareActor('assets/arrow_up.flr', animation: 'has_shortcut', fit: BoxFit.fitHeight, color: Colors.grey,))
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 30),
                      child: Text(
                        string.text('shortcuts'),
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ],
                )),
            Hints.bhint(context, b),
            Hints.deltahint(context, a, b, c, delta),
            Hints.hint(context, a, b, c),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
    );
  }
}
