import 'dart:ui';

import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  String warning;

  Alert({@required this.warning});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 5),
        child: Dialog(
          insetAnimationCurve: Curves.elasticInOut,
          insetAnimationDuration: Duration(seconds: 1),
          insetPadding: EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Colors.white,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(warning, style: TextStyle(fontSize: 23),textAlign: TextAlign.center,)),
            ),
            width: 100,
            height: 100,
          ),
        ));
  }
}
