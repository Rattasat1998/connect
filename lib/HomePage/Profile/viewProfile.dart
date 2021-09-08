import 'package:connnection/CustomUI/Carlender.dart';
import 'package:connnection/CustomUI/CustomProfile.dart';
import 'package:connnection/HomePage/ProviderFarm/Profile/navigator.dart';
import 'package:connnection/HomePage/ProviderFarm/Profile/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key, this.result}) : super(key: key);
  final result;

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool mainClick = false;
  bool myDetailClick = false;
  bool groupClick = false;

  Color colorBase = Color(0xff1c2229);

  @override
  void initState() {
    super.initState();
    mainClick = true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProfile>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Color(0xff1c2229),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Container(
                          width: 130,
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
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Image.asset(
                        'assets/icons/bgp.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 205,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff1c2229),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  provider
                                      .setNavigator(NavigatorItemProfile.main);
                                  setState(() {
                                    mainClick = true;
                                    myDetailClick = false;
                                    groupClick = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        5, // Space between underline and text
                                  ),
                                  decoration: BoxDecoration(
                                      border: mainClick != false
                                          ? Border(
                                              bottom: BorderSide(
                                              color: Colors.white,
                                              width: 1.0, // Underline thickness
                                            ))
                                          : Border(
                                              bottom: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0, // Underline thickness
                                            ))),
                                  child: Text(
                                    "หน้าหลัก",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  provider.setNavigator(
                                      NavigatorItemProfile.myDetail);
                                  setState(() {
                                    mainClick = false;
                                    myDetailClick = true;
                                    groupClick = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        5, // Space between underline and text
                                  ),
                                  decoration: BoxDecoration(
                                      border: myDetailClick != false
                                          ? Border(
                                              bottom: BorderSide(
                                              color: Colors.white,
                                              width: 1.0, // Underline thickness
                                            ))
                                          : Border(
                                              bottom: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0, // Underline thickness
                                            ))),
                                  child: Text(
                                    "ข้อมูลส่วนตัว",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  provider
                                      .setNavigator(NavigatorItemProfile.group);
                                  setState(() {
                                    mainClick = false;
                                    myDetailClick = false;
                                    groupClick = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        5, // Space between underline and text
                                  ),
                                  decoration: BoxDecoration(
                                      border: groupClick != false
                                          ? Border(
                                              bottom: BorderSide(
                                              color: Colors.white,
                                              width: 1.0, // Underline thickness
                                            ))
                                          : Border(
                                              bottom: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0, // Underline thickness
                                            ))),
                                  child: Text(
                                    "กลุ่ม",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 10,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomProfile(
                              result:widget.result,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 145,
                    left: 120,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.result['name'],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 175,
                    left: 120,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.result['status'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 12,
                                    ),
                                    Text(
                                      'นครพนม 48000',
                                      style: TextStyle(fontSize: 12),
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
                  Positioned(
                      top: 255,
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: buildPages()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPages() {
    final provider = Provider.of<NavigationProfile>(context);
    final navigation = provider.navigator;

    switch (navigation) {
      case NavigatorItemProfile.main:
        return mainClick == true ? buildMain() : Container();
      case NavigatorItemProfile.myDetail:
        return buildMyDetail();
      case NavigatorItemProfile.group:
        return buildGroup();
    }
  }

  Widget buildMain() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 165,
              height: 45,
              decoration: BoxDecoration(
                  color: colorBase,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  '50',
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 8,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                      letterSpacing: 1),
                                )
                              ],
                            ),
                            Text(
                              'ถูกใจ',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
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
                                  '10',
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 8,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                            Text(
                              'ผู้ติดตาม',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              itemSize: 10.0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
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
                                      Theme.of(context).textTheme.bodyText1,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
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
          ),
          Positioned(
              right: 0,
              child: Container(
                width: 190,
                height: 200,
                color: Colors.black12,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => CalendarScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                    size: 100,
                  ),
                ),
              )),
          Positioned(
              top: 55,
              child: TextButton(
                onPressed: () {
                },
                child: Text('Weather'),
              )),
        ],
      ),
    );
  }

  Container buildMyDetail() {
    return Container(
      width: 350,
      height: 180,
      child: Column(
        children: [Text('ข้อมูลส่วนตัว')],
      ),
    );
  }

  Container buildGroup() {
    return Container(
      width: 350,
      height: 180,
      child: Column(
        children: [Text('กลุ่ม')],
      ),
    );
  }
}
