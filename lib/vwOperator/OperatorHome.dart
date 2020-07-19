import 'package:announcer/entity/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OperatorHome extends StatelessWidget {
  final String title;
  Login login;
  OperatorHome({Key key, this.title, this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OperatorSFW(title: "Operator");
  }
}

class OperatorSFW extends StatefulWidget {
  final String title;

  const OperatorSFW({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OperatorSFWState(this.title);
  }
}

class _OperatorSFWState extends State {
  final String title;
  @override 
  _OperatorSFWState(this.title);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Text(title +"body"),
    );
  }
}
