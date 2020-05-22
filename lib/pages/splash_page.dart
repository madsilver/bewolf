import 'package:bewolf/utils/nav.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future futureB = Future.delayed(Duration(seconds: 3));

    Future.wait([futureB]).then((List values) {
      push(context, LoginPage(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
