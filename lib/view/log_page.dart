import 'package:calc/model/screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';

class calcLog extends StatefulWidget {
  const calcLog({Key? key}) : super(key: key);

  @override
  State<calcLog> createState() => _calcLogState();
}
class _calcLogState extends State<calcLog> {
  
  @override
  void initState() {
    ///mainPage로부터 opcontroller의 screenModel을 어떻게 전달받을 것인지.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        child: ListView(
          children: List.generate(10, (index) => Result("input", "result")),
        ),
      );
  }
  Container Result(String input, String result){
    return Container(
      child: Text("$input, $result"),
    );
  }
}
