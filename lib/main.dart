import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final message = "Initial Message.";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(message:this.message),
    );
  }
}

class MyPageState extends State<MyPage> {
  final _stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._stateController.dispose();
    super.dispose();
  }

  void laodOnPressed() {
    Firestore.instance.document("users/memo")
        .get().then((DocumentSnapshot ds) {
          setState(() {
            this._stateController.text = ds["word"];
          });
          print("status=$this.status");
        });
  }

  void saveOnPressed() {
    Firestore.instance.document("users/memo")
        .updateData({"word":_stateController.text})
        .then((value) => print("success"))
        .catchError((value) => print("error $value"));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter State Sample'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _stateController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: RaisedButton(
                  onPressed: saveOnPressed,
                  child: Text("Save")),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: RaisedButton(
                  onPressed: saveOnPressed,
                  child: Text("Load")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  final String message;
  MyPage({this.message}):super() {}
  @override
  State<StatefulWidget> createState() => new MyPageState();
}