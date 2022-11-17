import 'package:calc/const.dart';
import 'package:calc/controller/operating_controller.dart';
import 'package:flutter/material.dart';
import 'package:calc/view/history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var controller = OperatingController();
  final List<String> buttons = constButtons;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData deviceData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("calculator"),
        actions: [
          ///how to make space for Icons
          ///will show eval log
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(
                  icon: const Icon(Icons.timer),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryPage(
                                history: controller.getHistory(),
                                historyLength: controller.getHistoryLength())));
                  }))
        ],
      ),
      body: Column(
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
                    margin: const EdgeInsets.all(screenMargin),
                    alignment: Alignment.topCenter,
                    child: controller.screenModel.input == ''
                        ? const Text(
                            "0",
                            style: TextStyle(fontSize: screenInputFontSize),
                          )
                        : Text(
                            controller.screenModel.input,
                            style:
                                const TextStyle(fontSize: screenInputFontSize),
                          ),
                  ), //input
                  Container(
                    margin: const EdgeInsets.all(screenMargin),
                    alignment: Alignment.centerRight,
                    child: Text(controller.screenModel.result,
                        style: const TextStyle(
                            fontSize: screenResultFontSize,
                            fontWeight: FontWeight.bold)),
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
      ),
    );
  }

  ///toMakeButtons
  Container dialButton(var input) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              shape: const CircleBorder()),
          onPressed: () {
            setState(() {
              controller.addInput("$input");
            });
          },
          child: Text(
            "$input",
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
