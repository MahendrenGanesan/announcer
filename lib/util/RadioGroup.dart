import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {

  final List<RadioList> fList;
  final Null Function(int value) onItemSelected;

  const RadioGroup({Key key, this.fList, this.onItemSelected}) : super(key: key);

  @override  
  RadioGroupWidget createState() => RadioGroupWidget(fList,onItemSelected);
}
  
class RadioList {
  String name;
  int index;
  String url;
  RadioList({this.name, this.index, this.url});
}
 
class RadioGroupWidget extends State {
 
  final List<RadioList> fList;
  final Null Function(int value) onItemSelected;
    String radioItem = '';
    int id = 1;

  RadioGroupWidget(this.fList, this.onItemSelected);
 
 
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
           Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 23))
              ),
 
           Expanded(
            child: Container(
            height: 350.0,
            child: Column(
              children: 
                fList.map((data) => RadioListTile(
                  title: Text("${data.name}"),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    onItemSelected(data.index);
                    setState(() {
                      radioItem = data.name ;
                      id = data.index;
                    });
                  },
                )).toList(),
            ),
          )),
          
        ],
    );
  }
}