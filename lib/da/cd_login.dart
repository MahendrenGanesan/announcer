import 'package:announcer/entity/login.dart';
import 'package:announcer/util/DBProvider.dart';

class DBLogin
{
  
  newLoginRaw(Login newLogin) async {
    final db = await DBProvider.db.database;
    var res = await db.rawInsert(
      "INSERT Into cd_login (phone,name,shortName,avathor,typeID,validTill)"
      " VALUES (${newLogin.phone},${newLogin.name},${newLogin.shortName},${""},${newLogin.typeID},${newLogin.validTill})");
    return res;
  }
  Future<bool> newLogin(Login newLogin) async {
    final db = await DBProvider.db.database;
    var res = await db.insert("cd_login", newLogin.toMap());
    return true;
  }

  getLogin(String phone) async {
    final db = await DBProvider.db.database;
    var res =await  db.query("cd_login", where: "phone = ?", whereArgs: [phone]);
    return res.isNotEmpty ? Login.fromMap(res.first) : Null ;
  }
  
  Future<Login> getLoginFirst() async {   
    final db = await DBProvider.db.database;
    var res =await  db.query("cd_login", orderBy:"id");
    return res.isNotEmpty ? Login.fromMap(res.first) : Future(() => null) ;
  }

  Future<bool> updateLogin(Login newLogin) async {
    final db = await DBProvider.db.database;
    var res = await db.update("cd_login", newLogin.toMap(),
        where: "phone = ?", whereArgs: [newLogin.phone]);
    return true;
  }

  Future<bool>deleteLogin(String phone) async {
    final db = await DBProvider.db.database;
    db.delete("cd_login", where: "phone = ?", whereArgs: [phone]);
    return true;
  }
}