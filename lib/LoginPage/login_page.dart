import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connnection/Core/Model/user.dart';
import 'package:connnection/DarkMode/darkthemeProvider.dart';
import 'package:connnection/HomePage/dashboard.dart';
import 'package:connnection/LoginPage/SignUp/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'Forget_Password/forget_password.dart';
import 'dart:ui';
import 'Provider_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  /// Provider
  var email, password, token;
  late final MyProvider myProvider;

  bool remember = true;
  bool _passwordVisible = true;
  String? dropdownvalue = 'ไทย';
  bool chaangeColor = false;

  var items = [
    'ไทย',
    'อังกฤษ',
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  /// Firebase
  late String userEmail;
  late bool success;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;
  bool isLoggedIn = false;
  User? currentUser;
  SharedPreferences? prefs;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  /// Facebook Login
  //static final FacebookLogin facebookSignIn = new FacebookLogin();

  /// Google Signin
  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

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
            'name': firebaseUser.displayName,
            'photo': firebaseUser.photoURL,
            'age': '',
            'email': firebaseUser.email,
            'address': '',
            //'password': '',
            'follow': '0',
            'like': '0',
            'rate': '0',
            'status': '',
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
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
          //await prefs?.setString('password', userModel.password);
          await prefs?.setString('follow', userModel.follow);
          await prefs?.setString('like', userModel.like);
          await prefs?.setString('rate', userModel.rate);
          await prefs?.setString('status', userModel.status);
          await prefs?.setString('createdDate', userModel.createdDate);
        }
        Fluttertoast.showToast(msg: "Sign in success");
        this.setState(() {
          isLoading = false;
        });
        myProvider.setId(firebaseUser.uid);
        //userProvider.setUsername(firebaseUser.displayName);
        //print('TOKENNNNN : ${myProvider.name}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        this.setState(() {
          isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Can not init google sign in");
      this.setState(() {
        isLoading = false;
      });
    }
  }

  signUp() async {
    String email = emailController.text.trim();
    String password = passController.text.trim();

    final User? user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;

    if (user != null) {
      setState(() {
        success = true;
        userEmail = user.email!;
        print("USER : " + userEmail);

        if (email == userEmail) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard()));

          Fluttertoast.showToast(msg: "Sign in Success");
        } else {
          Fluttertoast.showToast(msg: "Sign in fail");
        }
      });
    } else {
      setState(() {
        success = false;
      });
    }
  }

  @override
  void initState() {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    super.initState();
  }

  Future<Null> loginEmail() async {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (password == doc["password"] && email == doc['email']) {
          Fluttertoast.showToast(msg: "ยินดีต้อนรับ");
          myProvider.setId(doc['id'].toString());

          Navigator.push(
            context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => Dashboard()),
          );
        } else {
          Fluttertoast.showToast(msg: "อีเมล หรือ รหัสผ่านไม่ถูกต้อง");
        }
      });
    });
/*    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (_, __, ___) => Dashboard()),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: chaangeColor != false
                    ? Color(0xff181d23)
                    : Color(0xfff5f5f5),
                //color: Color(0xff1D2229),
                borderRadius: BorderRadius.only(
                    //topRight: Radius.circular(40),
                    //topLeft: Radius.circular(40),
                    //bottomLeft: Radius.circular(40),
                    //bottomRight: Radius.circular(40),
                    ),
              ),
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
                            //dropdownColor: Color(0xff3d3f43)
                            iconEnabledColor: Colors.black87,
                            value: dropdownvalue,
                            icon: Icon(Icons.arrow_drop_down),
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
                          width: 10,
                        ),
                        Container(
                          decoration: new BoxDecoration(
                              //color: Colors.white10,
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(30),
                              //     topRight: Radius.circular(30),
                              //     bottomLeft: Radius.circular(30),
                              //     bottomRight: Radius.circular(30)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     blurRadius: 2.0,
                              //     spreadRadius: 0.5,
                              //     color: Colors.black12,
                              //     offset: Offset(
                              //       0.0, // Move to right 10  horizontally
                              //       2.0, // Move to bottom 10 Vertically
                              //     ),
                              //   )
                              //],
                              ),
                          child: Row(
                            children: [
                              FlutterSwitch(
                                width: 75.0,
                                height: 37.0,
                                toggleSize: 30.0,
                                value: themeProvider.isDarkTheme,
                                //borderRadius: 30.0,
                                padding: 4.0,
                                activeToggleColor: Colors.white,
                                inactiveToggleColor: Colors.black38,
                                activeColor: Colors.black45,
                                inactiveColor: Color(0xffdad9d9),

                                activeIcon: Icon(Icons.nightlight_round,
                                    color: Colors.black),

                                inactiveIcon: Icon(
                                  Icons.wb_sunny,
                                  color: Color(0xFF242424),
                                ),
                                inactiveText: "LIGHT",
                                activeText: "NIGH",
                                valueFontSize: 10.0,
                                //borderRadius: 10,
                                activeTextColor: Color(0xfff1f1f1),
                                inactiveTextColor: Color(0xff535353),
                                showOnOff: true,
                                onToggle: (value) {
                                  setState(() {
                                    themeProvider.changeTheme();
                                    if (value) {
                                      chaangeColor = true;
                                    } else {
                                      chaangeColor = false;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        buildHeader(),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFieldEmail(),
                        buildTextFieldPassword(),
                        buildRememberMe(),
                        buildLoginButton(),
                        buildForgetPassword(),
                        buildDot1(),
                        buildDot2(),
                        buildOrConnectTo(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 160,
                              height: 35,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    gradient: LinearGradient(colors: [
                                      Color(0xff1171C4),
                                      Color(0xff1171C4)
                                    ])),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 3, 0, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Color(0xff1171C4),
                                        child: Image.asset(
                                            'assets/icons/11222.png'),
                                      ),
                                      //),
                                      // children: [
                                      //   Icon(
                                      //     LineIcons.facebook,
                                      //     color: Colors.white,
                                      //     size: 30,
                                      //   ),

                                      FlatButton(
                                        onPressed: () {},
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 2),
                                            child: Text(
                                              'Facebook',
                                              style: GoogleFonts.lato(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 2,
                              height: 30,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 155,
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
                                    color: Colors.white),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 3, 0, 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        // child: CircleAvatar(
                                        //   radius: 150,
                                        child: Image.asset(
                                          'assets/icons/google.png',
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                      // child: Padding(
                                      //   padding: const EdgeInsets.fromLTRB(10, 3, 0, 5),
                                      //   child: Row(
                                      //     // children: [
                                      //     //   Icon(
                                      //     //     LineIcons.googleLogo,
                                      //     //     color: Colors.red,
                                      //     //     size: 25,
                                      //     //   ),
                                      FlatButton(
                                        onPressed: () {},
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 2),
                                            child: Text(
                                              'Google',
                                              style: GoogleFonts.lato(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ยังไม่มีบัญชีผู้ใช้",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff7E838A),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => Signup()),
                                );
                              },
                              child: Text('ลงทะเบียน',
                                  style: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    fontSize: 17,
                                    color: Color(0xff1F849E),
                                    fontStyle: FontStyle.normal,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildOrConnectTo() {
    return Text(
      'หรือ',
      style: TextStyle(
        fontSize: 15,
        color: Color(0xff7E838A),
      ),
    );
  }

  CircleAvatar buildDot2() {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Color(0xff7e7f80),
    );
  }

  CircleAvatar buildDot1() {
    return CircleAvatar(
      radius: 15,
      backgroundColor: Color(0xff3f4349),
    );
  }

  InkWell buildForgetPassword() {
    return InkWell(
      child: Text(
        'ลืมรหัสผ่าน',
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 18,
          color: Color(0xff1F849E),
          fontStyle: FontStyle.normal,
        ),
      ),
      onTap: () {
        // TODO something about forget password
        Navigator.push(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => Forget()),
        );
      },
    );
  }

  Text buildHeader() {
    return Text('Connection',
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyText1,
          fontSize: 48,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 8,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.0, 2.0),
              blurRadius: 2,
              color: Colors.black54,
            ),
          ],
        ));
  }

  Container buildLoginButton() {
    return Container(
      width: 300,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          //gradient: LinearGradient(colors: [Colors.black54, Colors.black])
        ),
        child: ElevatedButton(
          child: Text(
            "ล็อกอิน",
            style: TextStyle(
                // textStyle: Theme.of(context).textTheme.bodyText1,
                fontSize: 20.5,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: Color(0xfff8f8f8),
                letterSpacing: 2),
          ),
          onPressed: email != null && password != null
              ? () {
                  loginEmail();
                }
              : null,
          style: ElevatedButton.styleFrom(
            primary:
                chaangeColor != false ? Color(0xff464748) : Color(0xff0f1217),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }

  Container buildRememberMe() {
    return Container(
      margin: EdgeInsets.fromLTRB(200, 0, 0, 0),
      child: Row(
        children: [
          Checkbox(
              checkColor: Colors.black,
              activeColor: Color(0xff878686),
              value: remember,
              onChanged: (value) {
                setState(() {
                  remember = value!;
                });
              }),
          Text(
            'จดจำการลงชื่อเข้าใช้',
            style: TextStyle(fontSize: 14, color: Color(0xff828282)),
          ),
        ],
      ),
    );
  }

  Container buildTextFieldEmail() {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(
              0.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: emailController,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Color(0xff4a4a4a),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
          hintText: 'อีเมล',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container buildTextFieldPassword() {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(
              0.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: passController,
        onChanged: (value) {
          setState(() {
            password = value;
          });

        },
        obscureText: _passwordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xff4a4a4a),
          ),
          hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
          hintText: 'รหัสผ่าน',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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
