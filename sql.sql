drop table IF EXISTS cd_login;
CREATE TABLE IF NOT EXISTS cd_login(phone TEXT, name TEXT,shortName TEXT, avathor BLOB, typeID int, validTill DateTime);
Insert into cd_Login
(phone			,name	,shortName,avathor, typeID 	,validTill)
values
('1','operator',	'Operator',''	,1		,DATETime('now','100 day')),
('2','Pilot',		'Pilot',''		,2		,DATETime('now','100 day')),
('3','tracker',		'tracker',''	,9		,DATETime('now','100 day'));

drop table IF EXISTS cd_trckr_schdl;
CREATE TABLE IF NOT EXISTS cd_trckr_schdl(ID INTEGER PRIMARY KEY AUTOINCREMENT,phone TEXT, oper_phone TEXT,week_days TEXT, hhmm int, dura_min int, longi int, latti int, validTill DateTime);
insert into 
cd_trckr_schdl(phone,oper_phone,week_days,hhmm,dura_min,longi,latti,validTill)
VALUES
('3','1','s,m,t,w,t,f,s','0800','30',1000,1000,DATETime('now','100 day')),
('3','1','s,m,t,w,t,f,s','1700','30',1000,1000,DATETime('now','100 day'));