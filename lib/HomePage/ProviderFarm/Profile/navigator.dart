import 'package:connnection/HomePage/ProviderFarm/Profile/provider.dart';
import 'package:flutter/cupertino.dart';

class NavigationProfile extends ChangeNotifier{
  NavigatorItemProfile _navigator = NavigatorItemProfile.main;

  NavigatorItemProfile get navigator => _navigator;

  void setNavigator(NavigatorItemProfile value) {
    _navigator = value;

    notifyListeners();


  }
}