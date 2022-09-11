import 'dart:collection';

import 'package:flutter/material.dart';


class HistoryPage extends StatefulWidget {
  final List<Map> record;
  const HistoryPage({Key? key, required this.record}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map> record = [];
  @override
  void initState() {
    record = widget.record;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(onPressed: (){
                  Navigator.pop(context);
              }, icon: Icon(Icons.calculate)),
            )
          ],
        ),
        body: ListView(
          children: List.generate(record.length, (index) => Result(record, index)),
        ),
      );
  }
  Container Result(List<Map> record, int index){
    return Container(
      decoration:BoxDecoration(
        color: Colors.white60,
      ) ,
      child: record[index] != Null
       ?Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue.shade400,
              width: 1
            )
          )
        ),
         child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: 
          [
            Text(record[index].keys.toString().replaceAll(RegExp("[()]"), '')),
            Text(record[index].values.toString().replaceAll(RegExp("[()]"), ''))
          ],
         ),
       )
      : Row(
        children: 
        [
          Text(" "),
          Text(" ")
        ]
      )
    );
  }
}
