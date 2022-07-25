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
