import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../login_page.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _passwordVisible = false;
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
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
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        buildTextFieldPassword(),
                        SizedBox(
                          height: 30,
                        ),
                        buildTextFieldNewPassword(),
                        SizedBox(
                          height: 50,
                        ),
                        buildResetPasswordButton()
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Text buildHeader() {
    return Text(
      'Create New Password',
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
      'new password must be different from previously uses password',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }

  CircleAvatar buildFirstdot() {
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black54,
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
      backgroundColor: Colors.black,
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

  /// Reset Password BUTTON
  Container buildResetPasswordButton() {
    return Container(
      width: 220,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            gradient:
                LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
        child: ElevatedButton(
          child: Text(
            "Reset Password",
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.bodyText1,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                letterSpacing: 1),
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => Login()),
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
}
