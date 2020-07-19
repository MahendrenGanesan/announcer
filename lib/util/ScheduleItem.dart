import 'package:announcer/entity/TrackerSchedule.dart';
import 'package:flutter/material.dart';

class ScheduleItem {
  TrackerSchedule _item;
  ScheduleItem(TrackerSchedule scheduleItem) {
    this._item = scheduleItem;
  }
  Widget item() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                    icon: new Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () => {print(_item.id)})
              ],
            ),
            Column(
              children: <Widget>[
                Text("Scheduled Time : ${_item.hhmm}",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                Text("Would be +/- ${_item.duraMin} minutes")
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                    icon: new Icon(Icons.edit),
                    onPressed: () => {print(_item.id)})
              ],
            )
          ],
        ),
      ),
    );
  }
}
