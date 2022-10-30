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

bool isNumHasDot(String element) {
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
    return true;
  } else {
    return false;
  }
}
