import 'package:calc/const.dart';
import 'package:calc/controller/operating_controller.dart';
import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  var OPcontroller = OperatingController();
  final List<String> buttons = [
    'C',
    '()',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'DEL',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("calculator"),
        actions: [
          ///how to make space for Icons
          ///will show eval log
          Icon(Icons.timer)
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white60,
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 3,
                    )),
                /*margin: EdgeInsets.all(screenMargin),*/
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.all(screenMargin),
                      alignment: Alignment.topCenter,
                      child: OPcontroller.screen.input == ''
                          ? Text(
                              "0",
                              style: TextStyle(fontSize: 25),
                            )
                          : Text(
                              OPcontroller.screen.input,
                              style: TextStyle(fontSize: 25),
                            ),
                    ), //input
                    Container(
                      margin: EdgeInsets.all(screenMargin),
                      alignment: Alignment.centerRight,
                      child: Text(OPcontroller.screen.result,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ), //answer part
                  ],
                ), //input part
              ),
            ), //screen part
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    border:
                        Border.all(color: Colors.blueGrey.shade400, width: 3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        padding: const EdgeInsets.all(10),
                        children: List.generate(
                            20, (index) => dialButton(buttons[index]))),
                  ],
                ),
              ),
            )
          ],
        ), //divide part to screen and buttons
      ), //전체 화면 지워되 될 것 같음
    );
  }

  ///toMakeButtons
  Container dialButton(var input) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade100, shape: CircleBorder()),
          onPressed: () {
            setState(() {
              OPcontroller.addInput("$input");
            });
          },
          child: Text(
            "$input",
            style: const TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          )),
    );
  }
}
