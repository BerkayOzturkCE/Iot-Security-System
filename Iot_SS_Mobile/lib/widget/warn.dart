import 'package:flutter/material.dart';
import 'package:security/util/appData.dart';

import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAlert extends StatelessWidget {
  final Widget child;

  CustomAlert({Key key, @required this.child}) : super(key: key);

  double deviceWidth;
  double deviceHeight;
  double dialogHeight;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size viewsSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait
        ? viewsSize.width
        : viewsSize.height;
    deviceHeight = orientation == Orientation.portrait
        ? viewsSize.height
        : viewsSize.width;
    dialogHeight = deviceHeight * (0.50);

    return MediaQuery(
      data: MediaQueryData(),
      child: GestureDetector(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.5,
            sigmaY: 0.5,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: deviceWidth * 0.9,
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showResultDialog(
    String resultText, String mainText, BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (context) => CustomAlert(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 15.0),
            Text(
              mainText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              resultText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40.0,
                  width: 130.0,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    borderSide: BorderSide(color: Colors.cyan),
                    child: Text(
                      'Okey',
                      style: TextStyle(
                        color: AppConstant.textColor,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    ),
  );
}
