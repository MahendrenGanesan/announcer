import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    //String path = join(databasesPath, 'announcer5.db');
    String path = 'db1.db';
    final sql = ''' drop table IF EXISTS cd_login;
                CREATE TABLE IF NOT EXISTS cd_login(ID INTEGER PRIMARY KEY AUTOINCREMENT, phone TEXT, name TEXT,shortName TEXT, avathor BLOB, typeID int, validTill TEXT);
                Insert into cd_Login
                (phone			,name	,shortName,avathor, typeID 	,validTill)
                values
                ('3','tracker',		'tracker',''	,3		,DATETime('now','100 day')),
                 ('1','operator',	'Operator',''	,1		,DATETime('now','100 day')),
                ('2','Pilot',		'Pilot',''		,2		,DATETime('now','100 day'));

                drop table IF EXISTS cd_trckr_schdl;
                CREATE TABLE IF NOT EXISTS cd_trckr_schdl(ID INTEGER PRIMARY KEY AUTOINCREMENT,phone TEXT, oper_phone TEXT,week_days TEXT, hhmm int, dura_min int, longi int, latti int, validTill TEXT);
                insert into 
                cd_trckr_schdl(phone,oper_phone,week_days,hhmm,dura_min,longi,latti,validTill)
                VALUES
                ('3','1','s,m,t,w,t,f,s','0800','30',1000,1000,DATETime('now','100 day')),
                ('3','1','s,m,t,w,t,f,s','1700','30',1000,1000,DATETime('now','100 day'));
              '''.split(";");

    return await openDatabase(path, version: 1, onOpen: (db) async {
     /* for(String  s in  sql)
      {
        s = s.trim();
        if (s!='' && s!=null && s.length>10)
          await db.execute(s); // to be remove after the original implementation
      }
      */
    }, onCreate: (Database db, int version) async {
       for(String  s in  sql)
      {
        s = s.trim();
        if (s!='' && s!=null && s.length>10)
        await db.execute(s); // to be remove after the original implementation
      }
    });
  }
}
