import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connnection/Core/Model/user.dart';
import 'package:connnection/Service/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';

class VerificationAccount extends StatefulWidget {
  final String username,email,password;
  const VerificationAccount({Key? key, required this.username, required this.email, required this.password}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<VerificationAccount> {
  SharedPreferences? prefs;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;


  bool isLoading = false;
  bool isLoggedIn = false;
  User? currentUser;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 5),
      ),
    );
  }


  signUp() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

      final User? firebaseUser = (await
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email,password: widget.password)).user;

      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .set({
            'id': firebaseUser.uid,
            'name': widget.username,
            'photo': 'https://cdn.pixabay.com/photo/2015/07/27/19/47/turtle-863336__340.jpg',
            'age':'',
            'email': firebaseUser.email,
            'address': 'ยังไม่ได้เพิิ่มที่อยู่',
            'password': widget.password,
            'follow':'0',
            'like': '0',
            'rate': '0',
            'status': '',
            'createdAt': DateTime.now(),
            'chattingWith': null
          });

          // Write data to local
          currentUser = firebaseUser;
          await prefs?.setString('id', currentUser!.uid);
          await prefs?.setString('name', currentUser!.displayName ?? "");
          await prefs?.setString('photo', currentUser!.photoURL ?? "");
        } else {
          DocumentSnapshot documentSnapshot = documents[0];
          UserModel userModel = UserModel.fromDocument(documentSnapshot);
          // Write data to local
          await prefs?.setString('id', userModel.id);
          await prefs?.setString('name', userModel.name);
          await prefs?.setString('photo', userModel.photo);
          await prefs?.setString('age', userModel.age);
          await prefs?.setString('email', userModel.email);
          await prefs?.setString('address', userModel.address);
          await prefs?.setString('password', userModel.password);
          await prefs?.setString('follow', userModel.follow);
          await prefs?.setString('like', userModel.like);
          await prefs?.setString('rate', userModel.rate);
          await prefs?.setString('status', userModel.status);
          await prefs?.setString('createdDate', userModel.createdDate);
        }
        Fluttertoast.showToast(msg: "Sign in success");
        this.setState(() {
          isLoading = false;
          isLoggedIn = true;
        });
        //myProvider.setname(firebaseUser.uid);
        Navigator.push(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => Login()),
        );
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        this.setState(() {
          isLoading = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            SizedBox(height: 20,),
            buildSubHeader(),
            buildSubsubHeader(),

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
                height: 250,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text('New email verification code',
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          letterSpacing: 1),),
                    SizedBox(height: 7,),
                    buildForm(),
                    SizedBox(height: 2,),
                    Text('Resend Email : 30 s',
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          letterSpacing: 1),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildHeader(){
    return Text(
      'Account Verification',
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
      'Please enter the 6-digit verification code that was',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }
  Text buildSubsubHeader(){
    return Text(
      'send to your@gmail.com The code is valid for 30 minutes.',
      style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 1),
    );
  }

  CircleAvatar buildFirstdot(){
    return CircleAvatar(
      radius: 7,
      backgroundColor: Colors.black54,
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
      backgroundColor: Colors.black,
    );
  }

  Form buildForm(){
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 30),

          child: PinCodeTextField(

            enablePinAutofill: false,
            keyboardAppearance: Brightness.dark,
            length: 6,
            obscureText: true,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.numberWithOptions(),
            autoDisposeControllers: true,
            obscuringCharacter: '*',
            blinkWhenObscuring: true,
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade200,
              fontWeight: FontWeight.bold,
            ),

            validator: (v) {
              if (v!.length < 3) {
                return "I'm from validator";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
                borderWidth:1.0,
                borderRadius: BorderRadius.circular(10.0),
                shape: PinCodeFieldShape.box,
                fieldHeight: 50,
                fieldWidth: 40,
                //activeFillColor: Colors.white
                activeColor: Colors.black
            ),
            cursorColor: Colors.black,
            animationDuration: Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: textEditingController,
            boxShadows: [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) async {
              if(v == textEditingController.text){
               signUp();
              }
              else{
                print("Error to Register");
              }
              print("Completed");
            },
            onChanged: (value) {
              setState(() {
               // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          )),
    );
  }

}
