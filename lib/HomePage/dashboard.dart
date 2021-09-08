import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Index/index0.dart';
import 'Index/index1.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key,}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;



  static List<Widget> _widgetOptions = <Widget>[
    Index0(),
    Index1(),
    Text(
      'Index 3',
    ),
    Text(
      'Index 3',
    ),
    Text(
      'Index 4',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/home1.png'),
                title: Text('หน้าหลัก',
                    style: TextStyle(
                        fontFamily: 'Prompt-Light',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold)),
                activeIcon: Image.asset('assets/icons/home2.png')),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/message1.png'),
                title: Text('ข้อความ',
                    style: TextStyle(
                        fontFamily: 'Prompt-Light',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold)),
                activeIcon: Image.asset(
                  'assets/icons/message2.png',
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/mark1.png',
                ),
                title: Text('ตลาดต่างๆ',
                    style: TextStyle(
                        fontFamily: 'Prompt-Light',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold)),
                activeIcon: Image.asset(
                  'assets/icons/mark2.png',
                )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/payment1.png'),
                title: Text('การชำระเงิน',
                    style: TextStyle(
                        fontFamily: 'Prompt-Light',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold)),
                activeIcon: Image.asset('assets/icons/payment2.png')),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/employment1.png'),
                title: Text('จ้างงาน',
                    style: TextStyle(
                        fontFamily: 'Prompt-Light',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold)),
                activeIcon: Image.asset('assets/icons/employment2.png')),
          ],
          onTap: _onItemTapped,
          iconSize: 10,
          backgroundColor: Color(0xff1c2229),
          currentIndex: _selectedIndex,
          activeColor: Color(0xffffbb00),
        ),
        tabBuilder: (context, index) {
          return _widgetOptions.elementAt(_selectedIndex);
        },
      ),
    );
  }
}
