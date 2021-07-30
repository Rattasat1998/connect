import 'package:connnection/LoginPage/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confirm_email.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _passwordVisible = false;
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            buildHeader(),
            SizedBox(
              height: 15,
            ),
            buildSubHeader(),
            SizedBox(
              height: 15,
            ),
            buildSubsubHeader(),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFirstdot(),
                SizedBox(
                  width: 10,
                ),
                buildCenterdot(),
                SizedBox(
                  width: 10,
                ),
                buildLastdot(),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.5,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    buildTextFieldUsername(),
                    SizedBox(
                      height: 30,
                    ),
                    buildTextFieldEmail(),
                    SizedBox(
                      height: 30,
                    ),
                    buildTextFieldPassword(),
                    SizedBox(
                      height: 30,
                    ),
                    buildTextFieldNewPassword(),
                    SizedBox(
                      height: 30,
                    ),
                    buildNextButton(), /// NEXT
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildneverMind(),
                        SizedBox(
                          width: 20,
                        ),
                        buildRemember()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Text buildHeader() {
    return Text(
      'Sign up',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.orangeAccent,
          letterSpacing: 1),
    );
  }

  Text buildSubHeader() {
    return Text(
      'Welcome to Connection',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }

  Text buildSubsubHeader() {
    return Text(
      'Create your account',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 14,
          //fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }

  CircleAvatar buildFirstdot() {
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black,
    );
  }

  CircleAvatar buildCenterdot() {
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black54,
    );
  }

  CircleAvatar buildLastdot() {
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black54,
    );
  }

  Container buildTextFieldUsername() {
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
              Icons.account_box,
              color: Colors.black54,
            ),
            hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
            hintText: 'Username',
            border: InputBorder.none,
            isDense: false),
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
            isDense: false),
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
          hintText: 'New Password',
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

  Container buildTextFieldNewPassword() {
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
          hintText: 'Repeat Password',
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

  /// Next BUTTON
  Container buildNextButton() {
    return Container(
      width: 170,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            gradient:
                LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(pageBuilder: (_, __, ___) => ConfirmEmail()),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      letterSpacing: 2),
                )),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Text buildneverMind() {
    return Text(
      'Already have an account?',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.white,
          letterSpacing: 1),
    );
  }

  InkWell buildRemember() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Text(
        'Login',
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.blue,
            letterSpacing: 1),
      ),
    );
  }
}
