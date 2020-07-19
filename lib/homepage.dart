import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePageSFW(title: 'Flutter Demo Home Page');
  }
}

class HomePageSFW extends StatefulWidget {
  HomePageSFW({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageSFWState createState() => _HomePageSFWState();
}

class _HomePageSFWState extends State<HomePageSFW> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have p ushed the button this many times:',
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/loginpage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
