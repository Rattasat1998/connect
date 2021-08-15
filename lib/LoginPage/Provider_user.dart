import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier{
  late String? _user;
  late String? _id;

  String? get user => _user;
  setUser(String name) {
    _user = name;
    notifyListeners();
  }

  String? get id => _id;
  setId(String name) {
    _id = name;
    notifyListeners();
  }
}