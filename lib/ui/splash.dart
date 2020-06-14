import 'package:chat_snap/ui/home_page.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var _iconSize = 50.0;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3), () {
      setState(() {
        _iconSize = 260;
        Future.delayed(Duration(milliseconds: 1200), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0003FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              curve: Curves.easeInExpo,
              duration: Duration(milliseconds: 900),
              width: _iconSize,
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
