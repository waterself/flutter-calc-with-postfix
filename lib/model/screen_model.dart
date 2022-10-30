import 'dart:collection';

import 'package:flutter/cupertino.dart';

class ScreenModel {
  String input;
  String result;
  ListQueue<Map> history;
  ScreenModel(this.input, this.result, this.history);
}
