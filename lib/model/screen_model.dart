import 'dart:collection';

class ScreenModel {
  String input;
  String result;
  ListQueue<Map> history;
  ScreenModel(this.input, this.result, this.history);
}
