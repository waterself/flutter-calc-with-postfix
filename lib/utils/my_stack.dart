//보통 들어가는 파일들 - 어디서든지 불러서 쓰는 함수, 분리시킬 수 있는 함수
class MyStack {
  final _data = <String>[];

  void push(String input) {
    _data.add(input);
  }

  void pop() {
    _data.removeLast();
  }

  String peak() {
    if (!empty()) {
      return _data.last;
    } else {
      return 'e';
    }
  }

  bool empty() {
    return _data.isEmpty;
  }

  @override
  String toString() {
    return _data.toString();
  }
}
