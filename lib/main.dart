import 'package:connnection/HomePage/dashboard.dart';
import 'package:connnection/LoginPage/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'DarkMode/darkthemeProvider.dart';
import 'DarkMode/themes.dart';
import 'HomePage/ProviderFarm/Profile/navigator.dart';
import 'HomePage/ProviderFarm/navigator.dart';
import 'LoginPage/Provider_user.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn =
  (prefs.getString('id') == null) ? false : prefs.getString('id');
  runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => NavigationProvider()),
          ChangeNotifierProvider(create: (context) => NavigationProfile()),
          ChangeNotifierProvider(create: (context) => MyProvider()),

        ],
        child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('th', 'TH'), // Thai
            ],
            theme: themeProvider.isDarkTheme ? themeDataDark : themeDataLight,
            builder: DevicePreview.appBuilder,
            home: ResponsiveWrapper.builder(
              isLoggedIn != null ? MyApp() : Dashboard(),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
            ),
          );
        }),
      )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? firebaseUser = firebaseAuth.currentUser;

    Future getCurrentUser() async {
      User? _user = firebaseAuth.currentUser;
      print("User: ${_user!.displayName ?? "None"}");
      return _user;}*/

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

