import 'package:connnection/LoginPage/SignUp/verify_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                height: 8,
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
                  height: MediaQuery.of(context).size.height/4,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      buildTextFieldEmail(),
                      SizedBox(
                        height: 40,
                      ),
                      buildConfirmButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text buildHeader() {
    return Text(
      'Confirm Your Email',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.orangeAccent,
          letterSpacing: 1),
    );
  }

  Text buildSubHeader() {
    return Text(
      'Please confirm the email you want to use with Connection.',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }

  Text buildSubsubHeader() {
    return Text(
      'Notification and verification will be sent to this email.',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 9,
          //fontWeight: FontWeight.bold,
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
      backgroundColor: Colors.black,
    );
  }

  CircleAvatar buildLastdot() {
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black54,
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
            hintText: 'example@gmail.com',
            border: InputBorder.none,
            isDense: false),
      ),
    );
  }

  /// Confirm BUTTON
  Container buildConfirmButton() {
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
                    PageRouteBuilder(pageBuilder: (_, __, ___) => VerificationAccount()),
                  );
                },
                child: Text(
                  'Confirm',
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

}
