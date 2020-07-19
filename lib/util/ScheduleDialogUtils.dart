import 'package:announcer/entity/TrackerSchedule.dart';
import 'package:announcer/util/numberpicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class ScheduleDialogUtils {
  static ScheduleDialogUtils _instance = new ScheduleDialogUtils.internal();

  static DateTime _dateTime;

  ScheduleDialogUtils.internal();

  factory ScheduleDialogUtils() => _instance;

  TrackerSchedule trackerSchedule = new TrackerSchedule();
  static void showCustomDialog(BuildContext context, int id,
      {@required String title,
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      int scheduleID = -1,
      @required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(/*title: Text(title),*/
              //content: /* Here add your custom widget  */,
              actions: <Widget>[
            Wrap(direction: Axis.horizontal, children: [
              Column(
                children: <Widget>[
                  Text("Mon"),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Tue"),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Wed"),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Thu"),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Fri"),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Sat",
                    style: TextStyle(color: Colors.red),
                  ),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Sun",
                    style: TextStyle(color: Colors.red),
                  ),
                  Checkbox(
                    value: true,
                    //onChanged: (value){toggleCheckbox(value);},
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
            ]),
            const Divider(
              color: Colors.black,
              height: 5,
              thickness: 3,
              indent: 5,
              endIndent: 0,
            ),
            Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Text(
                    "Time",
                  ),
                  TimePickerSpinner(
                    itemHeight: 40,
                    itemWidth: 40,
                    is24HourMode: false,
                    normalTextStyle: TextStyle(fontSize: 15),
                    highlightedTextStyle:
                        TextStyle(fontSize: 20, color: Colors.red),
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      _dateTime = time;
                    },
                  ),
                ]),
                const Divider(
                  color: Colors.black,
                  height: 5,
                  thickness: 3,
                  indent: 20,
                  endIndent: 0,
                ),
                Column(children: <Widget>[
                  Text("Alert minutes"),
                  new NumberPicker.integer(
                    initialValue: 10,
                    minValue: 0,
                    maxValue: 90,
                    itemExtent: 40,
                    onChanged: (num value) {},
                  )
                ])
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 5,
              thickness: 3,
              indent: 5,
              endIndent: 0,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: const Text('this location'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: const Text('choose from map'),
                ),
              ],
            ),
            Wrap(direction: Axis.horizontal, children: [
              FlatButton(
                child: Text(okBtnText),
                onPressed: okBtnFunction,
              ),
              FlatButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context)),
            ]),
          ]);
        });
  }
}
