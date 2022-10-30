import 'dart:collection';
import 'package:calc/utils/check_num.dart';

import 'package:calc/model/screen_model.dart';
import 'package:calc/utils/my_stack.dart';

//String element
class OperatingController {
  var screenModel = ScreenModel('', '0', ListQueue(10));

  bool isFirstBracket = true;

  ListQueue<Map> getHistory() {
    return screenModel.history;
  }

  int getHistoryLength() {
    return screenModel.history.length;
  }

  void addInput(var input) {
    if (input == 'C') {
      deleteAllInput();
    } else if (input == 'DEL') {
      deleteOneInput();
    } else if (input == '=') {
      screenModel.result = operator(screenModel.input);
      // String eval = screenModel.input.replaceAll('=', '') + ' = ' + screenModel.result;
      String exp = screenModel.input;
      if (screenModel.history.length < 5) {
        screenModel.history.add({exp: screenModel.result});
        print(screenModel.history.length);
        print(screenModel.history);
      } else {
        screenModel.history.removeFirst();
        screenModel.history.add({exp: screenModel.result});
        print(screenModel.history.length);
        print(screenModel.history);
      }
    } else if (input == '()') {
      var tmp = screenModel.input.substring(-1);
      //how to "x(" if prev is num?
      if (isFirstBracket == true && isNum(tmp)) {
        screenModel.input += '(';
        isFirstBracket = false;
      } else if (isFirstBracket == false) {
        screenModel.input += ')';
        isFirstBracket = true;
      }
    } else if (input == '%') {
      if (screenModel.input == '') {
        screenModel.input += '1/100';
      } else {
        var tmp = screenModel.input;
        screenModel.input += '/100';
      }
    } else {
      screenModel.input += input;
    }
  }

  void deleteAllInput() {
    screenModel.input = '';
    isFirstBracket = true;
  }

  void deleteOneInput() {
    var last = screenModel.input.substring(-1);
    var res;
    res = screenModel.input.substring(0, screenModel.input.length - 1);
    screenModel.input = res;
    if (last == '(') {
      isFirstBracket == true;
    }
  }

  String operator(String input) {
    String convertedInput = input.replaceAll('x', '*');
    // ignore: avoid_print
    print(convertedInput);
    return evalExp(inToPost(convertedInput));
  }

  String add(String a, String b) {
    double x = double.parse(a);
    double y = double.parse(b);
    double res = x + y;
    return res.toString();
  }

  String sub(String a, String b) {
    double x = double.parse(a);
    double y = double.parse(b);
    double res = x - y;
    return res.toString();
  }

  String mul(String a, String b) {
    double x = double.parse(a);
    double y = double.parse(b);
    double res = x * y;
    return res.toString();
  }

  String div(String a, String b) {
    double x = double.parse(a);
    double y = double.parse(b);
    double res = x / y;
    return res.toString();
  }

  String inToPost(String input) {
    String pre = input;
    int len = input.length;
    print("len: $len");
    MyStack opStack = MyStack();
    String pos = '';
    print("intopost: $pre");
    for (int i = 0; i < pre.length; i++) {
      var element = pre[i];
      //입력이 비면 패스
      if (element == ' ') {
        continue;
      }
      //숫자면 출력식에 바로 추가
      if (isNumHasDot(element)) {
        pos += element;
        //숫자가 아니면 공백
        if (isNum(element)) {
          // pos += ' ';
        } else {
          continue;
        }
      }
      if (element == '(') {
        opStack.push(element);
      }
      if (element == '*') {
        pos += '@';
        if (opStack.empty()) {
          opStack.push(element);
        } else {
          var buff = opStack.peak();
          if (getOrder(buff, element)) {
            pos += opStack.peak();
            opStack.pop();
            pos += ' ';
          }
          opStack.push(element);
        }
      }
      if (element == '/') {
        pos += '@';
        if (opStack.empty()) {
          opStack.push(element);
        } else {
          var buff = opStack.peak();
          if (getOrder(buff, element)) {
            pos += opStack.peak();
            opStack.pop();
            pos += ' ';
          }
          opStack.push(element);
        }
      }
      if (element == '+') {
        pos += '@';
        if (opStack.empty()) {
          opStack.push(element);
        } else {
          var buff = opStack.peak();
          if (getOrder(buff, element)) {
            pos += opStack.peak();
            opStack.pop();
            pos += ' ';
          }
          opStack.push(element);
        }
      }
      if (element == '-') {
        pos += '@';
        if (opStack.empty()) {
          opStack.push(element);
        } else {
          var buff = opStack.peak();
          if (getOrder(buff, element)) {
            pos += opStack.peak();
            opStack.pop();
            pos += ' ';
          }
          opStack.push(element);
        }
      }
      if (element == ')') {
        pos += "@";
        var buff = opStack.peak();
        opStack.pop();
        while (buff != '(') {
          pos += buff;
          pos += ' ';
          buff = opStack.peak();
          opStack.pop();
        }
      }
    }
    print(opStack.toString());
    while (!opStack.empty()) {
      String buff = opStack.peak();
      opStack.pop();
      if (buff != '(') {
        pos += buff;
      }
    }
    pos += '=';
    String ret = pos.toString().replaceAll(',', '');
    print("ret: $ret");
    return ret;
  }

  bool getOrder(String stackOP, String newOP) {
    if (stackOP == '(') {
      return false;
    }
    if (newOP == '+' || newOP == '-') {
      return true;
    } else {
      if (stackOP == '*' || stackOP == '/') {
        return true;
      } else {
        return false;
      }
    }
  }

  String evalExp(String input) {
    print("evalexp $input");
    String exp = input.replaceAll(' ', '');
    print("exp: $exp");
    MyStack evStack = MyStack();
    int len = exp.length;
    String d = '';
    String res = '';
    for (int i = 0; i < len; i++) {
      var element = exp[i];
      if (element == ' ') {
        continue;
      }
      //숫자가 나오면
      if (isNumHasDot(element)) {
        d += element;
        //숫자가 끝나면 push
      } else if (d != ' ' && element == '@' ||
          element == "+" ||
          element == "-" ||
          element == "*" ||
          element == "/") {
        if (d != '') {
          evStack.push(d);
        }
        print(evStack.toString());
        d = '';
        if (element == '+' ||
            element == '-' ||
            element == '*' ||
            element == '/') {
          String b = evStack.peak();
          evStack.pop();

          String a = evStack.peak();
          evStack.pop();

          String res = '';
          switch (element) {
            case ('+'):
              print("a, b = $a , $b");
              res = add(a, b);
              print(res);
              break;
            case ('-'):
              print("a, b = $a , $b");
              res = sub(a, b);
              print(res);
              break;
            case ('*'):
              print("a, b = $a , $b");
              res = mul(a, b);
              print(res);
              break;
            case ('/'):
              print("a, b = $a , $b");
              res = div(a, b);
              print(res);
              break;
          }
          evStack.push(res);
        }
      } else {
        continue;
      }
    }
    double? doubleTryParse = double.tryParse(evStack.peak());
    if (doubleTryParse != null &&
        doubleTryParse != double.nan &&
        doubleTryParse != double.infinity) {
      double tmp = double.parse(evStack.peak());
      double fraction = tmp - tmp.truncate();
      if (fraction == 0) {
        int ret = tmp.toInt();
        res = ret.toString();
      } else {
        res = tmp.toString();
      }
    } else if (doubleTryParse == null ||
        doubleTryParse == double.nan ||
        doubleTryParse == double.infinity) {
      res = "ERROR";
    } else {
      res = evStack.peak();
    }
    print("result: $res");
    return res;
  }
}
