import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Index/index0.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Index0(),
    Text(
      'Index 1',
    ),
    Text(
      'Index 2',
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
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Market',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: 'Hire',
            backgroundColor: Colors.black87,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 18,
        selectedLabelStyle: TextStyle(color: Colors.orange),
        onTap: _onItemTapped,
      ),
    );
  }
}
