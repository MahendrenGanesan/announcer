import 'package:announcer/da/cd_login.dart';
import 'package:announcer/da/cd_trckr_schdl.dart';
import 'package:announcer/entity/login.dart';
import 'package:announcer/main.dart';
import 'package:announcer/util/ImageUtility.dart';
import 'package:announcer/util/ScheduleDialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'ScheduleList.dart';
import 'TrackerMap.dart';

class ViewerHome extends StatelessWidget {
  final String title;
  Login login;
  ViewerHome({Key key, this.title, this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewerSFW(title: "Operator");
  }
}

class ViewerSFW extends StatefulWidget {
  final String title;

  const ViewerSFW({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ViewerSFWState();
  }
}

class _ViewerSFWState extends State {
  int _selectedIndex = 0;
  File _pickedImage;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    TrackerMap(),
    ScheduleList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              _pickImage();
            },
            child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.green,
                child: ClipOval(
                    child: _pickedImage != null
                        ? Image(
                            image: FileImage(_pickedImage),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          )
                        : login.avathor.trim() == ""
                            ? Icon(Icons.face)
                            : Utility.imageFromBase64String(login.avathor))),
          ),
          title: const Text('Tracker')),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Schedule'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                ScheduleDialogUtils.showCustomDialog(context, 0,
                    title: "Gallary",
                    okBtnText: "Save",
                    cancelBtnText: "Cancel",
                    okBtnFunction: () => Navigator.pop(context));
                // Add your onPressed code here!
              },
              child: Icon(Icons.add_alert),
              backgroundColor: Colors.red,
            )
          : Container(),
    );
  }

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(
          source: imageSource, maxHeight: 100, maxWidth: 100);
      if (file != null) {
        setState(() => _pickedImage = file);

        String avatharString = await Utility.base64StringFromFile(file);
        Login updLogin = new Login(
            phone: login.phone,
            name: login.name,
            avathor: avatharString,
            typeID: login.typeID,
            validTill: login.validTill);
        (new DBLogin()).updateLogin(updLogin);
      }
    }
  }
}
