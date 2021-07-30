import 'package:connnection/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DarkMode/ThemeData.dart';
import 'DarkMode/darkthemeProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) { return themeChangeProvider;},
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context ),
            home: NewPage(),
          );
        }
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}




