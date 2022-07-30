import 'dart:collection';

import 'package:calc/model/screen_model.dart';
import 'package:calc/utils/MyStack.dart';


//String element
class OperatingController {
  var screen = ScreenModel('', '0', -1, List.empty(growable: true));

  bool isFirstBracket = true;
  
  List<Map> getRecord(){
    return screen.record;
  }

  void addInput(var input) {
    if (input == 'C') {
      deleteAllInput();
    } else if (input == 'DEL') {
      deleteOneInput();
    } else if (input == '=') {
      screen.result = operator(screen.input);
      // 연산자 앞에 숫자없음, 0/1문제같은건 여기서 예외로 빼기
      // String eval = screen.input.replaceAll('=', '') + ' = ' + screen.result;
      String exp = screen.input;
      if (screen.top < 10) {
        screen.record.add({exp:screen.result});
        screen.top++;
        print(screen.record);
      } else {
        screen.record.removeAt(0);
        screen.record.add({exp:screen.result});
      }
    } else if (input == '()') {
      var tmp = screen.input.substring(-1);
      //how to "x(" if prev is num?
      if (isFirstBracket == true && isNum(tmp)) {
        screen.input += '(';
        isFirstBracket = false;
      } else if (isFirstBracket == false) {
        screen.input += ')';
        isFirstBracket = true;
      }
    } else if (input == '%') {
      if (screen.input == '') {
        screen.input += '1/100';
      } else {
        var tmp = screen.input;
        screen .input += '/100';
      }
    } else {
      screen.input += input;
    }
  }

  void deleteAllInput() {
    screen.input = '';
    isFirstBracket = true;
  }

  void deleteOneInput() {
    var last = screen.input.substring(-1);
    var res;
    res = screen.input.substring(0, screen.input.length - 1);
    screen.input = res;
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
      if (element == "0" ||
          element == "1" ||
          element == "2" ||
          element == "3" ||
          element == "4" ||
          element == "5" ||
          element == "6" ||
          element == "7" ||
          element == "8" ||
          element == "9" ||
          element == ".") {
        pos += element;
        //숫자가 아니면 공백
        if (element != "0" ||
            element != "1" ||
            element != "2" ||
            element != "3" ||
            element != "4" ||
            element != "5" ||
            element != "6" ||
            element != "7" ||
            element != "8" ||
            element != "9") {
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
      if (element == "0" ||
          element == "1" ||
          element == "2" ||
          element == "3" ||
          element == "4" ||
          element == "5" ||
          element == "6" ||
          element == "7" ||
          element == "8" ||
          element == "9" ||
          element == ".") {
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
    res = evStack.peak();
    print("result: $res");
    return res;
  }

  bool isNum(String element) {
    if (element == "0" ||
        element == "1" ||
        element == "2" ||
        element == "3" ||
        element == "4" ||
        element == "5" ||
        element == "6" ||
        element == "7" ||
        element == "8" ||
        element == "9") {
      return true;
    } else {
      return false;
    }
  }
}
