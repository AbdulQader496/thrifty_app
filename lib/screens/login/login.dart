import 'dart:io';

import 'package:thrifty_app/config/config.dart';
import 'package:thrifty_app/screens/screens.dart';
import 'package:thrifty_app/shared/shared.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    updateStatusBarColor(context);

    return Scaffold(
      body: SafeArea(
        top: !Platform.isIOS,
        bottom: false,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: TopSection(),
                    clipper: WaveClipper(),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: BottomSection(),
            ),
          ],
        ),
      ),
    );
  }
}
