import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connnection/HomePage/Profile/viewProfile.dart';
import 'package:connnection/LoginPage/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  final profile;

  const Profile({
    Key? key,
    this.profile,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _enabled = true;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      //isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    //await googleSignIn.disconnect();
    //await googleSignIn.signOut();
    await _auth.signOut();

    this.setState(() {
      //isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[600],
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: double.infinity,
              height: 50,
              color: Color(0xff1c2229),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 13.5,
                            backgroundColor: Color(0xff848587),
                            child: Icon(
                              Icons.search,
                              color: Colors.black87,
                            )),
                        CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.notifications,
                              color: Color(0xff848587),
                              size: 29,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.profile['id'])
                    .get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var result = snapshot.data;
                    print(result['name']);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                'บัญชีผู้ใช้',
                                style: GoogleFonts.lato(
                                    textStyle:TextStyle(color: Colors.white54),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 2),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Color(0xff1c2229),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${result['name']}",
                                              style: GoogleFonts.lato(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.white,
                                                  letterSpacing: 1),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          LineIcons.mapMarker,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          '${result['address']}',
                                                          style: GoogleFonts.lato(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              letterSpacing: 1),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //_showPicker(context);
                                        // TODO Go to Profile Edit
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  ViewProfile(
                                                    result: result,
                                                  )),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                            child: ClipOval(
                                                child: Container(
                                          height: 350.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            child: result['photo'] == null
                                                ? Placeholder()
                                                : Image.network(
                                                    result['photo'],
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ))),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 18,
                                    decoration: BoxDecoration(
                                        color: Color(0xff1c2229),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: Colors.white38,
                                            size: 18,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                ' Email : ${result['email']}',
                                                style: GoogleFonts.lato(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                    color: Colors.white,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 0),
                                            child: InkWell(
                                              onTap: () {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Row(
                                                  children: [
                                                    Icon(
                                                      LineIcons.coffee,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Coffee',
                                                      style: GoogleFonts.lato(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          color: Colors.white,
                                                          letterSpacing: 1),
                                                    )
                                                  ],
                                                )));
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height:
                                        MediaQuery.of(context).size.height / 18,
                                    decoration: BoxDecoration(
                                        color: Color(0xff1c2229),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.thumb_up,
                                                        size: 12,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${result['like']}',
                                                        style: GoogleFonts.lato(
                                                            textStyle:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                            fontSize: 8,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: Colors.white,
                                                            letterSpacing: 1),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    'ถูกใจ',
                                                    style: GoogleFonts.lato(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText1,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white,
                                                        letterSpacing: 1),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${result['follow']}',
                                                        style: GoogleFonts.lato(
                                                            textStyle:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                            fontSize: 8,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: Colors.white,
                                                            letterSpacing: 1),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'ผู้ติดตาม',
                                                    style: GoogleFonts.lato(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText1,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white,
                                                        letterSpacing: 1),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: 4.5,
                                                    minRating: 1,
                                                    itemSize: 10.0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  Text(
                                                    'คะแนน',
                                                    style: GoogleFonts.lato(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText1,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white,
                                                        letterSpacing: 1),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'การตั้งค่า',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(color: Colors.white54),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 2),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              /// Setting
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c2229),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'การอัปเดท',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'V.10.0.3 (เสถียร)',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'เปลี่ยนภาษา (Languages)',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'ไทย',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'สถานะ',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${result['status']}',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'บัญชีธนาคาร)',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'เปิดใช้งาน',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.amber,
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'ข้อมูลส่วนตัว',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'ประวัติการเข้าสู่ระบบ',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'ความปลอดภัย',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'เปิดบัญชีนิติบุคคล',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ศูนย์ดูแลลูกค้า',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(color: Colors.white54),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 2),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c2229),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    )),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'ข้อเสนอแนะ',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'คำถามที่พบบ่อย',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'เกี่ยวกับ Connection',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'รายงานปัญหาการใช้งานแอปพลิเคชัน',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'ติดต่อเจ้าหน้าที่',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                  ],
                                ),
                              ),

                              /// Other
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'อื่น ๆ',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(color: Colors.white54),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 2),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Color(0xff1c2229),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    )),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'ข้อกำหนดและเงื่ยนไข',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'แชร์ Application',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 0, 0, 0),
                                        child: Container(
                                          height: 50,
                                          child: InkWell(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'สนับสนุน',
                                                  style: GoogleFonts.lato(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              /// Logout
                              Container(
                                child: TextButton(
                                    onPressed: () {
                                      // TODO Logout Button!
                                      handleSignOut();
                                    },
                                    child: Text(
                                      'ออกจากระบบ',
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    )),
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'การเข้าสู่ระบบครั้งถัดไปจะถูกบันทึกไว้ใน',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(color: Colors.white54),
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white54,
                                        letterSpacing: 1),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'ประวัติการเข้าสู่ระบบ',
                                        style: GoogleFonts.lato(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.blue,
                                            letterSpacing: 1),
                                      )),
                                  Text(
                                    'โปรดระวัง',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(color: Colors.white54),
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white54,
                                        letterSpacing: 1),
                                  ),
                                ],
                              ),
                              Text(
                                'เปลี่ยนรหัสผ่านบ่อยครั้งดเพื่อป้องกันการโจรกรรมบัญชีของคุณ',
                                style: GoogleFonts.lato(
                                    textStyle:TextStyle(color: Colors.white54),
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white54,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey,
                      enabled: _enabled,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 12,
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
