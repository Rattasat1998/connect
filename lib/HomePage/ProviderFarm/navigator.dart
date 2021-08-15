import 'package:connnection/HomePage/ProviderFarm/provider.dart';
import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier{
  NavigatorItem _navigator = NavigatorItem.priceUp;

  NavigatorItem get navigator => _navigator;

  void setNavigator(NavigatorItem value) {
    _navigator = value;

    notifyListeners();


  }
}