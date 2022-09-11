
import 'package:calcwithpostfix/const.dart';
import 'package:calcwithpostfix/controller/operating_controller.dart';
import 'package:flutter/material.dart';
import 'package:calcwithpostfix/view/history_page.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  var OPcontroller = OperatingController();
  final List<String> buttons = constButtons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("calculator"),
        actions: [
          ///how to make space for Icons
          ///will show eval log
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              icon: Icon(Icons.timer),
              onPressed:(){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(record: OPcontroller.getRecord())));
              } 
            )
          )
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
                      // //레이아웃빌더 높이,넓이등 다양한 속성을 계산해야 할 때 사용
                      // child: LayoutBuilder(builder: (context, constraints) {
                        
                      //   if(OPcontroller.screen.input == ''){
                      //     return Text("0"
                      //     );
                      //   }
                      //   else{
                      //     return Text(
                      //         OPcontroller.screen.input,
                      //         style: TextStyle(fontSize: screenInputFontSize),
                      //       );
                      //   }
                      // },)
                      child: OPcontroller.screen.input == ''
                          // ignore: prefer_const_constructors
                          // 조건을 벨류에만 주는 것이 좋아보임
                           ?Text(
                              "0",
                              style: TextStyle(fontSize: screenInputFontSize),
                            )
                          : Text(
                              OPcontroller.screen.input,
                              style: TextStyle(fontSize: screenInputFontSize),
                            ),
                    ), //input
                    Container(
                      margin: EdgeInsets.all(screenMargin),
                      alignment: Alignment.centerRight,
                      child: Text(OPcontroller.screen.result,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: screenResultFontSize, fontWeight: FontWeight.bold)),
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
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
