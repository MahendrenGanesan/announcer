import 'package:announcer/da/cd_login.dart';
import 'package:announcer/util/RadioGroup.dart';
import 'package:announcer/vwOperator/OperatorHome.dart';
import 'package:announcer/vwPilot/PilotHome.dart';
import 'package:announcer/vwViewer/ViewerHome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'entity/login.dart';
import 'homepage.dart';

Widget _defaultHome = RegPage();
DBLogin appdbLogin;
Login login;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appdbLogin = DBLogin();
  login = await appdbLogin.getLoginFirst();
  runApp(MyApp(title: "app page"));
}

class MyApp extends StatelessWidget {
  final String title;
  const MyApp({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        title: 'Phone Authentication',
        routes: <String, WidgetBuilder>{
          '/homepage': (BuildContext context) => HomePage(),
          '/loginpage': (BuildContext context) => MyApp(title: title),
          '/Operator': (BuildContext context) => OperatorHome(),
          '/Pilot': (BuildContext context) => PilotHome(),
          '/Viewer': (BuildContext context) => ViewerHome(),
        },
        /*  theme: ThemeData(
          primaryColor: const Color(0xFF02BB9F),
          primaryColorDark: const Color(0xFF167F67),
          accentColor: const Color(0xFF167F67),
        ),*/
        home: login == null
            ? new RegPage(title: title)
            : login.typeID == 3
                ? new ViewerHome(title: title, login: login)
                : login.typeID == 2
                    ? new PilotHome(title: title, login: login)
                    : new OperatorHome(
                        title: title,
                        login: login) /* 1- Operator, 2- Pilot, 3- viewer */

        );
  }
}

class RegPage extends StatefulWidget {
  RegPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  String phoneNo;
  String smsOTP;
  String verificationId = "";
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<int> loginUserType(
      Null Function(int value) onItemSelected, Function() okClick(int value)) {
    int retValue = 0;
    showDialog(
      context: context,
      child: new AlertDialog(
        title: const Text("Are you a?"),
        content: RadioGroup(
            fList: [
              RadioList(
                index: 1,
                name: "Operator Manager who owns and also drives a vehicle",
              ),
              RadioList(
                index: 2,
                name: "A driver who reports to Operator manager",
              ),
              RadioList(
                index: 3,
                name: "Looking for a vehicle",
              )
            ],
            onItemSelected: (int value) {
              retValue = value;
              onItemSelected(value);
            }),
        actions: [
          new FlatButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                okClick(retValue);
              }),
        ],
      ),
    );
    return Future.value(retValue);
  }

  Future<void> navigateToAppPage(FirebaseUser currentUser) {
    loginUserType((int typeID) {
      // print("Count was selected.");
    }, (int typeID) {
      Login newLogin = new Login(
          name: currentUser.displayName,
          phone: currentUser.phoneNumber,
          avathor: currentUser.photoUrl,
          typeID: typeID);
      appdbLogin.newLogin(newLogin);
      Navigator.of(context).pushReplacementNamed('/homepage');
    });
    return null;
  }

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      navigateToAppPage(user);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      Navigator.of(context).pop();
      navigateToAppPage(currentUser);
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

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
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Phone Number Eg. +910000000000'),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
            ),
            (errorMessage != ''
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                verifyPhone();
              },
              child: Text('Verify'),
              textColor: Colors.white,
              elevation: 7,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
