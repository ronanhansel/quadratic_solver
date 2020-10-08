import 'package:catex/catex.dart';
import 'package:flutter/material.dart';

class Hints {
  double a;
  double b;
  double c;

  @required
  Hints({this.a, this.b, this.c});

  static bhint(context, b) {
    if (b is int) {
      if (!b.isOdd) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: 20,
              color: Colors.red[600],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('~ Since b is an even number, apply this formula:'),
                Wrap(
                  children: [
                    CaTeX('\\frac {-b + \\sqrt {\u0394}}  {a}'),
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return Container(
          width: 0,
          height: 0,
        );
      }
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  static deltahint(context, a, b, c, delta) {
    double baa = b / 2 * a;
    var ba;
    if (baa * 10 - (baa.toInt()) * 10 == 0) {
      ba = baa.toInt();
    } else {
      ba = baa;
    }
    if (delta == 0) {
      String content = '- \\frac { $b } { ${2 * a} } = ${-ba}';
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('~ Since \u0394 = 0'),
              Wrap(
                children: [
                  CaTeX('x\u2081 = x\u2082 = - \\frac b {2 * a} = '),
                  CaTeX(content),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }

  static hint(context, a, b, c) {
    double caa = c / a;
    var ca;
    if (caa * 10 - (caa.toInt()) * 10 == 0) {
      ca = caa.toInt();
    } else {
      ca = caa;
    }
    if (a + b + c == 0) {
      String content = '\\frac { $c } { $a } = $ca';
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('~ Since a + b + c = 0'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CaTeX(' x\u2081 = 1; '),
                  Row(
                    children: [
                      CaTeX('x\u2082 = \\frac c a = '),
                      CaTeX(content),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (a - b + c == 0) {
      String content = '- \\frac { $c } { $a } = ${-ca}';
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('~ Since a - b + c = 0'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CaTeX(' x\u2081 = -1; '),
                  Row(
                    children: [
                      CaTeX('x\u2082 = - \\frac c a = '),
                      CaTeX(content),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No other shortcuts available'),
          ],
        ),
      ),
    );
  }
}
