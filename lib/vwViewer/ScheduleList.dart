import 'package:announcer/da/cd_trckr_schdl.dart';
import 'package:announcer/entity/TrackerSchedule.dart';
import 'package:announcer/util/ScheduleItem.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatefulWidget {
  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  Future<List<TrackerSchedule>> scheduleList;
  final List<int> colorCodes = <int>[50, 100, 200, 300, 400];
  _ScheduleListState() {}

  // A Separate Function called from itemBuilder
  Widget buildBody(BuildContext ctxt, int index) {
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.cyan[colorCodes[index % 5]],
        child: new ScheduleItem(scheduleListItems[index]).item());
  }

  List<TrackerSchedule> scheduleListItems;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: new DBTrackerSchedule().getTrackerSchedules(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          scheduleListItems = snapshot.data;
          return new ListView.builder(
              itemCount: scheduleListItems.length,
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildBody(ctxt, index));
        } else {
          return Container(
              width: 50.0,
              height: 50.0,
              child: (CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green,
                ),
                backgroundColor: Colors.red,
                value: 0.2,
              )));
        }
      },
    );
    /*return new ListView.builder(
        itemCount: scheduleList == null ? 0 : scheduleList.length,
        itemBuilder: (BuildContext ctxt, int index) => buildBody(ctxt, index));
        */
  }
}
