import 'package:announcer/entity/TrackerSchedule.dart';
import 'package:announcer/util/DBProvider.dart';

class DBTrackerSchedule {
  newTrackerScheduleRaw(TrackerSchedule newTrackerSchedule) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert(
        "INSERT Into cd_trckr_schdl(phone,oper_phone,week_days,hhmm,dura_min,longi,latti,validTill)"
        " VALUES (${newTrackerSchedule.phone},${newTrackerSchedule.oper_phone},${newTrackerSchedule.week_days},${newTrackerSchedule.hhmm}, ${newTrackerSchedule.duraMin},${newTrackerSchedule.longi},${newTrackerSchedule.latti},${newTrackerSchedule.validTill})");
    return res;
  }

  Future<bool> newTrackerSchedule(TrackerSchedule newTrackerSchedule) async {
    final db = await DBProvider.db.database;
    var res = await db.insert("cd_trckr_schdl", newTrackerSchedule.toMap());
    return true;
  }

  getTrackerSchedule(String phone) async {
    final db = await DBProvider.db.database;
    var res = await db
        .query("cd_trckr_schdl", where: "phone = ?", whereArgs: [phone]);
    return res.isNotEmpty ? TrackerSchedule.fromMap(res.first) : Null;
  }

  getTrackerScheduleByID(int id) async {
    final db = await DBProvider.db.database;
    var res =
        await db.query("cd_trckr_schdl", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? TrackerSchedule.fromMap(res.first) : Null;
  }

  Future<TrackerSchedule> getTrackerScheduleFirst() async {
    final db = await DBProvider.db.database;
    var res = await db.query("cd_trckr_schdl", orderBy: "id");
    return res.isNotEmpty
        ? TrackerSchedule.fromMap(res.first)
        : Future(() => null);
  }

  Future<List<TrackerSchedule>> getTrackerSchedules() async {
    List<TrackerSchedule> retList = new List<TrackerSchedule>();
    final db = await DBProvider.db.database;
    var res = await db.query("cd_trckr_schdl", orderBy: "id");
    for (int i = 0; i < res.length; i++)
      res.forEach((element) {
        retList.add(TrackerSchedule.fromMap(element));
      });

    return retList;
  }

  Future<bool> updateTrackerSchedule(TrackerSchedule newTrackerSchedule) async {
    final db = await DBProvider.db.database;
    var res = await db.update("cd_trckr_schdl", newTrackerSchedule.toMap(),
        where: "phone = ?", whereArgs: [newTrackerSchedule.phone]);
    return true;
  }

  Future<bool> deleteTrackerSchedule(String phone) async {
    final db = await DBProvider.db.database;
    db.delete("cd_trckr_schdl", where: "phone = ?", whereArgs: [phone]);
    return true;
  }
}
