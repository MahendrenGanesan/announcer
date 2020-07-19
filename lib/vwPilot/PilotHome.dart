import 'package:announcer/entity/login.dart';
import 'package:flutter/widgets.dart';

class PilotHome extends StatelessWidget {
  final String title;
  Login login;
  PilotHome({Key key, this.title, this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PilotSFW(title: "Operator");
  }
}

class PilotSFW extends StatefulWidget {
  final String title;

  const PilotSFW({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PilotSFWState();
  }
}

class _PilotSFWState extends State {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
