import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int user_id = 0; // Initialize with an empty string

  int get newUserId => user_id;

  void setUserId(int newUserId) {
    user_id = newUserId;
    notifyListeners();
  }
}
