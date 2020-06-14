import 'package:chat_snap/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_snap/provider/cam_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CamController>.value(
      value: CamController()..init(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cam Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}
