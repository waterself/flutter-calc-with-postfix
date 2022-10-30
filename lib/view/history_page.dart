import 'dart:collection';
import 'package:calc/model/screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';

class HistoryPage extends StatefulWidget {
  final ListQueue<Map> history;
  final int historyLength;
  const HistoryPage(
      {Key? key, required this.history, required this.historyLength})
      : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ListQueue<Map> history = ListQueue();
  late int historyLength;
  @override
  void initState() {
    history = widget.history;
    historyLength = widget.historyLength;
    super.initState();
    print(history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.calculate)),
          )
        ],
      ),
      body: ListView(
        children:
            List.generate(historyLength, (index) => result(history, index)),
      ),
    );
  }

  Container result(ListQueue<Map> history, int index) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white60,
        ),
        //history.elementAt(index) != empty
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.blue.shade400, width: 1))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(history
                  .elementAt(index)
                  .keys
                  .toString()
                  .replaceAll(RegExp("[()]"), '')),
              Text(history
                  .elementAt(index)
                  .values
                  .toString()
                  .replaceAll(RegExp("[()]"), ''))
            ],
          ),
        ));
    //: Row(children: [Text(" "), Text(" ")]));
  }
}
