import 'package:calc/model/screen_model.dart';
import 'package:calc/controller/MyStack.dart';

//String element
class OperatingController {
  var screen = ScreenModel('', '0');

  bool isFirstBracket = true;

  void addInput(var input) {
    if (input == 'C') {
      deleteAllInput();
    } else if (input == 'DEL') {
      deleteOneInput();
    } else if (input == '=') {
      screen.result = operator(screen.input);
    } else if (input == '()') {
      var tmp = screen.input;
      if (isFirstBracket == true) {
        screen.input = "(" + tmp;
        isFirstBracket = false;
      } else if (isFirstBracket == false) {
        screen.input = tmp + ")";
        isFirstBracket = true;
      }
    } else if (input == '%') {
      if (screen.input == '') {
        screen.input += '1/100';
      } else {
        var tmp = screen.input;
        screen.input += '/100';
      }
    } else {
      screen.input += input;
    }
  }

  void deleteAllInput() {
    screen.input = '';
  }

  void deleteOneInput() {
    var res;
    res = screen.input.substring(0, screen.input.length - 1);
    screen.input = res;
  }

  String operator(String input) {
    String convertedInput = input.replaceAll('X', '*');
    // ignore: avoid_print
    print(convertedInput);
    return evalExp(inToPost(input));
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
    print("intopost");
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
      if (element == "*") {
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
    print(pos);
    String ret = pos.toString().replaceAll(',', '');
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
    print("evalexp");
    String exp = input.replaceAll(' ', '');
    print(exp);
    MyStack evStack = MyStack();
    int len = exp.length;
    String d = '';
    String res = '';
    for (int i = 0; i < len; i++) {
      var element = exp[i];
      if (element == ' ') {
        print("pass");
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
        evStack.push(d);
        print(evStack.toString());
        d = '';
      } else {
        //숫자가 아니고 빈칸도 아님 -> 연산자임
        if (element == '+' ||
            element == '-' ||
            element == '*' ||
            element == '/') {
          ///해당부분이 에러
          String b = evStack.peak();
          // b.replaceAll('[0-9]', '');
          evStack.pop();

          String a = evStack.peak();
          // a.replaceAll('[0-9]', '');
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
      }
    }
    res = evStack.peak();
    print("result: $res");
    return res;
  }
}
