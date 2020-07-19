import 'dart:convert';
 

Login LoginFromJson(String str) {
  final jsonData = json.decode(str);
  return Login.fromMap(jsonData);
}

String LoginToJson(Login data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class Login
{ 
  final String    phone;
  final String    name;
  final String    shortName;
  final String    avathor;
  final int       typeID;
  final String    validTill;

  Login({ this.phone, this.name, this.avathor,this.typeID, this.validTill,this.shortName});
  factory Login.fromMap(Map<String, dynamic> json) => new Login( 
        phone: json["phone"],
        name: json["name"],
        avathor: json["avathor"],
        typeID: json["typeID"],
        validTill: json["validTill"]==""? DateTime.now().add(new Duration(days: 50)).toString() :json["validTill"],
        shortName: json["shortName"]==""? json["name"]:json["shortName"],
      );

  Map<String, dynamic> toMap() => { 
        "phone": phone,
        "name": name,
        "avathor": avathor,
        "typeID":typeID,
        "validTill": validTill==null? DateTime.now().add(new Duration(days: 50)).toString() :validTill,
        "shortName":shortName=="" ? name:shortName,
      };

}
