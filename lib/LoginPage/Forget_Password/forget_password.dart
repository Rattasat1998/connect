import 'package:connnection/LoginPage/Forget_Password/verify_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
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
                          child: Icon(Icons.arrow_back,size: 30,),
                        onTap: (){
                            Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                buildHeader(),
                SizedBox(height: 15,),
                buildSubHeader(),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildFirstdot(),
                    SizedBox(width: 10,),
                    buildCenterdot(),
                    SizedBox(width: 10,),
                    buildLastdot(),
                  ],
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 520,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        )
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        buildTextFieldEmail(),
                        SizedBox(height: 50,),
                        buildLoginButton(),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildneverMind(),
                            SizedBox(width: 20,),
                            buildRemember()
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Text buildHeader(){
    return Text(
      'Forget Your Password',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.orangeAccent,
          letterSpacing: 1),
    );
  }

  Text buildSubHeader(){
    return Text(
      'Please Enter Your Email Address To Receive a Verification Code ',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }

  CircleAvatar buildFirstdot(){
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black,
    );
  }
  CircleAvatar buildCenterdot(){
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black54,
    );
  }

  CircleAvatar buildLastdot(){
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
          hintText: 'Email Address',
          border: InputBorder.none,
          isDense: false
        ),
      ),
    );
  }

  /// SUBMIT BUTTON
  Container buildLoginButton(){
    return Container(
      width: 200,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            gradient:
            LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
        child: ElevatedButton(
          child: Text(
            "Submit",
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.bodyText1,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                letterSpacing: 8),
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => Verification()),
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

  Text buildneverMind(){
    return Text('Nevermind',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: Colors.white,
          letterSpacing: 1),);
  }

  InkWell buildRemember(){
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Text('I remember it',
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.blue,
            letterSpacing: 1),),
    );
  }

}
