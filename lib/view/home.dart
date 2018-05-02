import 'dart:async';
import 'dart:convert';
import 'package:youtivi/Global.dart';
import 'package:youtivi/util/network.dart' as network;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new HomeView());

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
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
  static const MethodChannel methodChannel =
      const MethodChannel('youtivi/platform');
  String platformName = 'unknown';
  bool isLoading = true;
  var _data = [];

  Future<Null> _loadData() async {
    updateStatusLoading(true);
    network.Network.getIP().then((http.Response result) {
        print("HHH"+result.body);
      setState(() {
//        _data = JSON.decode(result.body);
      });
      updateStatusLoading(false);
    }).catchError((e) {
      print(e);
      updateStatusLoading(false);
    });
  }

  updateStatusLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  Widget _buildRow(int position) {
    return new ListTile(
      title: new Text("${_data[position]["login"]}",
          style: TextStyle(fontSize: 18.0)),
      onTap: () {
        new GlobalKey<ScaffoldState>().currentState.showSnackBar(new SnackBar(
            content: new Text("You clicked item number $position")));
      },
    );
  }

  Column buildButtonColumn(IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;

    return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ]);
  }

  Widget buildListView() {
    return new ListView.builder(
        itemCount: _data.length * 2,
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) return new Divider();

          final index = position ~/ 2;

          return _buildRow(index);
        });
  }

  @override
  void initState() {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    Container button = new Container(
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ]));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
//      body: new Center(
//          child: new Column(children: <Widget>[
//        new Image.asset('images/bg_home.jpg', fit: BoxFit.cover),
//        new Container(
//            color: Colors.red,
//            child: new Stack(
//              children: <Widget>[
//                new Container(
//                    child: new Center(
//                  child: !isLoading
//                      ? new Container()
//                      : new CircularProgressIndicator(),
//                )),
////            button
//              ],
//            ))
//      ])),
      body: new Center(
          child: new Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Image.asset('images/bg_home.jpg'),
              new Expanded(
                child: buildListView(),
              )
            ],
          ),
          new Center(
            child:
                !isLoading ? new Container() : new CircularProgressIndicator(),
          )
        ],
      )),
      floatingActionButton: new FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
