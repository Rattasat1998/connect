import 'package:connnection/DarkMode/darkthemeProvider.dart';
import 'package:connnection/DarkMode/themes.dart';
import 'package:connnection/HomePage/dashboard.dart';
import 'package:connnection/LoginPage/SignUp/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'Forget_Password/forget_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  bool remember = true;
  bool _passwordVisible = false;
  String? dropdownvalue = 'THAILAND';
  var items = [
    'THAILAND',
    'ENGLISH',
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownvalue = value as String?;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.0,
                            spreadRadius: 0.5,
                            color: Colors.black12,
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              2.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          FlutterSwitch(
                            width: 120.0,
                            height: 45.0,
                            toggleSize: 45.0,
                            value: themeChange.darkTheme,
                            borderRadius: 20.0,
                            padding: 5.0,
                            activeToggleColor: Colors.white,
                            inactiveToggleColor: Colors.black38,
                            activeColor: Colors.black45,
                            inactiveColor: Colors.white,
                            activeIcon:
                                Icon(Icons.nightlight_round, color: Colors.black),
                            inactiveIcon: Icon(
                              Icons.wb_sunny,
                              color: Color(0xFFFFDF5D),
                            ),
                            onToggle: (value) {
                              setState(() {
                                themeChange.darkTheme = value;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              buildHeader(),
              SizedBox(
                height: 80,
              ),
              buildTextFieldEmail(),
              SizedBox(
                height: 20,
              ),
              buildTextFieldPassword(),
              buildRememberMe(),
              buildLoginButton(),
              SizedBox(height: 20,),
              buildForgetPassword(),
              SizedBox(height: 20,),
              buildDot1(),
              SizedBox(height: 20,),
              buildDot2(),
              SizedBox(height: 10,),
              buildOrConnectTo(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                width: 150,
                height: 35,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      gradient:
                      LinearGradient(colors: [Color.fromRGBO(66 ,103, 178,1), Color.fromRGBO(66 ,103, 178,1)])),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(LineIcons.facebook,color: Colors.white,size: 25,),
                        FlatButton(onPressed: (){}, child: Text('Facebook',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            fontSize: 18,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,),)),
                      ],
                    ),
                  ),
                ),
              ),
                  SizedBox(width: 30,),
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.black12,
                  ),
                  SizedBox(width: 30,),
                  Container(
                    width: 150,
                    height: 35,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                              spreadRadius: 0.5,
                              color: Colors.black12,
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                2.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.googleLogo,color: Colors.red,size: 25,),
                            FlatButton(onPressed: (){}, child: Text('Google',
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context).textTheme.bodyText1,
                                fontSize: 18,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,),)),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do not have account?'),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) => Signup()),
                      );
                    },
                    child: Text('Sign up',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          fontSize: 18,
                          color: Colors.blue,
                          fontStyle: FontStyle.normal,)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  Text buildOrConnectTo(){
    return Text('or connect with',
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.bodyText1,
        fontSize: 15,
        fontStyle: FontStyle.normal,),);
  }

  CircleAvatar buildDot2(){
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.black45,
    );
  }

  CircleAvatar buildDot1(){
    return CircleAvatar(
      radius: 15,
      backgroundColor: Colors.black54,
    );
  }

  InkWell buildForgetPassword(){
    return InkWell(
      child: Text('Forget your password?',
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 18,
            color: Colors.blue[500],
            fontStyle: FontStyle.normal,),
      ),
      onTap: (){
        // TODO something about forget password
        Navigator.push(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => Forget()),
        );
      },
    );
  }

  Text buildHeader(){
    return Text(
      'Connection',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 48,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 8),
    );
  }
  Container buildLoginButton(){
    return Container(
      width: 300,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            gradient:
            LinearGradient(colors: [Colors.black54, Colors.black87])),
        child: ElevatedButton(
          child: Text(
            "Login",
            style: GoogleFonts.aleo(
                textStyle: Theme.of(context).textTheme.bodyText1,
                fontSize: 30,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                letterSpacing: 8),
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => Dashboard()),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }

  Container buildRememberMe(){
    return Container(
      margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
      child: Row(
        children: [
          Checkbox(
              value: remember,
              onChanged: (value) {
                setState(() {
                  remember = value!;
                });
              }),
          Text(
            'Remember Me',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
  Container buildTextFieldEmail() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            spreadRadius: 0.5,
            color: Colors.black12,
            offset: Offset(
              0.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black54,
          ),
          hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
          hintText: 'Email Address',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  Container buildTextFieldPassword() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            spreadRadius: 0.5,
            color: Colors.black12,
            offset: Offset(
              0.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        obscureText: _passwordVisible,
        controller: passController,
        keyboardType: TextInputType.visiblePassword,
        onChanged: (value) {
          value = passController.text;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black54,
          ),
          hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
          hintText: 'Password',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}
