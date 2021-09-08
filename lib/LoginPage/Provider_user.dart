import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier{
  late String? _user;
  late String? _name;
  late String? _id;

  String? get user => _user;
  setUser(String name) {
    _user = name;
    notifyListeners();
  }

  String? get name => _name;
  setName(String name) {
    _name = name;
    notifyListeners();
  }

  String? get id => _id;
  setId(String name) {
    _id = name;
    notifyListeners();
  }
}