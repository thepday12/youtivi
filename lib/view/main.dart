import 'dart:async';
import 'dart:io';
import 'package:youtivi/Global.dart';
import 'package:youtivi/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: primary_color,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void startTimeOut() async {
     new Timer(const Duration(milliseconds: 3500),startHomeView);
  }

  void startHomeView(){
    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (__) => new HomeView()));
  }

  static const MethodChannel methodChannel =
      const MethodChannel('youtivi/platform');
  String platformName = 'unknown';

  Future<Null> _getPlatformName() async {
    String result;
    try {
      result = await methodChannel.invokeMethod('getPlatformName');
    } on PlatformException {
      result = 'unknown';
    }
    setState(() {
      platformName = result;
    });
  }


  @override
  void initState() {
    super.initState();
    startTimeOut();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              app_name,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      backgroundColor: new Color(primary_color.value),
    );
  }
}
