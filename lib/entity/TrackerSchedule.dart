import 'dart:convert';

import 'package:announcer/util/DBProvider.dart';

TrackerSchedule TrackerScheduleFromJson(String str) {
  final jsonData = json.decode(str);
  return TrackerSchedule.fromMap(jsonData);
}

String TrackerScheduleToJson(TrackerSchedule data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class TrackerSchedule {
  final int id;
  final String phone;
  final String oper_phone;
  final String week_days;
  final String hhmm;
  // = (100 + DateTime.now().hour).toString().substring(1, 3) +
  //    (100 + DateTime.now().minute).toString().substring(1, 3);
  final int duraMin;
  final int longi;
  final int latti;
  final String validTill;

  TrackerSchedule(
      {this.id,
      this.phone,
      this.oper_phone,
      this.week_days,
      this.hhmm,
      this.duraMin,
      this.longi,
      this.latti,
      this.validTill});

  factory TrackerSchedule.fromMap(Map<String, dynamic> json) =>
      new TrackerSchedule(
        id: json["id"],
        phone: json["phone"],
        oper_phone: json["oper_phone"],
        week_days: json["week_days"],
        hhmm: json["hhmm"].toString(),
        duraMin: json["duraMin"],
        longi: json["longi"],
        latti: json["latti"],
        validTill: json["validTill"] == ""
            ? DateTime.now().add(new Duration(days: 50)).toString()
            : json["validTill"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "phone": phone,
        "oper_phone": oper_phone,
        "week_days": week_days,
        "hhmm": hhmm,
        "duraMin": duraMin,
        "longi": longi,
        "latti": latti,
        "validTill": validTill == null
            ? DateTime.now().add(new Duration(days: 50)).toString()
            : validTill,
      };
}
