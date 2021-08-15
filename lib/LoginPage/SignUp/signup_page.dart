import 'package:connnection/LoginPage/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_auth/email_auth.dart';
import 'confirm_email.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  var username, email, password;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body:  Column(
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
              Container(
                  height: screenSize.height/1.2,
                  width: screenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildHeader(),
                      buildSubHeader(),
                      buildSubsubHeader(),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenSize.height/1.9,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              )),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: buildTextFieldUsername(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: buildTextFieldEmail(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: buildTextFieldPassword(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: buildTextFieldNewPassword(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: buildNextButton(),
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


                                /// NEXT


                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


            ],
          ),
      ),
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

  /// USERNAME
  Container buildTextFieldUsername() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height/16,
      width: screenSize.width,

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
        controller: nameController,
        onChanged: (val) {
          username = val;
        },
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

  /// EMAIL
  Container buildTextFieldEmail() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height/16,
      width: screenSize.width,
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
      child: TextFormField(
        controller: emailController,
        onChanged: (val) {
          email = val;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter your Email';
          } else if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return null;
          } else {
            return "ใส่ อีเมล ให้ถูกต้อง";
          }
        },
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

  /// PASSWORD
  Container buildTextFieldPassword() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height/16,
      width: screenSize.width,
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
        obscureText: _passwordVisible1,
        controller: passController,
        keyboardType: TextInputType.visiblePassword,
        onChanged: (value) {
          password = value;
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
              _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible1 = !_passwordVisible1;
              });
            },
          ),
        ),
      ),
    );
  }

  /// REPEAT PASSWORD
  Container buildTextFieldNewPassword() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height/16,
      width: screenSize.width,
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
        obscureText: _passwordVisible2,
        controller: repeatPassController,
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
              _passwordVisible2 ? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible2 = !_passwordVisible2;
              });
            },
          ),
        ),
      ),
    );
  }

  /// Next BUTTON
  Container buildNextButton() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height/16,
      width: screenSize.width/2,
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
                  if (password == repeatPassController.text) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => ConfirmEmail(
                              username: username,
                              email: email,
                              password: password)),
                    );
                  }
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
