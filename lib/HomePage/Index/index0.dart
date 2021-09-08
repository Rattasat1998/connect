import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connnection/HomePage/Profile/profile.dart';
import 'package:connnection/HomePage/ProviderFarm/navigator.dart';
import 'package:connnection/HomePage/ProviderFarm/provider.dart';
import 'package:connnection/LoginPage/Provider_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Index0 extends StatefulWidget {
  const Index0({Key? key}) : super(key: key);

  @override
  _Index0State createState() => _Index0State();
}

class _Index0State extends State<Index0> with SingleTickerProviderStateMixin {
  bool onClick = false;
  SharedPreferences? prefs;
  String? photoUrl = '';
  var profile;

  int _currentIndex=0;

  List cardList=[
    Item1(),
    Item2(),
    Item3(),
    Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  late final MyProvider myProvider;
  bool isLoading = false;

  @override
  void initState() {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    super.initState();
    imageProfile();
  }
  imageProfile() {
    String? id = myProvider.id;
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(id == doc['id']){
          setState(() {
            photoUrl = doc['photo'];
            profile = doc.data();
            isLoading = true;
          });
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                color: Color(0xff1c2229),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Please Logout');
                      },
                      child: Text('Connection',
                          style: TextStyle(
                            fontFamily: 'Prompt-Light',
                            fontSize: 20,
                            letterSpacing: 3,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 1.0,
                                color: Colors.black54,
                                offset: Offset(1, 2),
                              ),
                            ],
                          )),
                    ),
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
                          Container(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => Profile(
                                          profile:profile,
                                        )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25.0,
                                    child: isLoading != false
                                        ? ClipOval(
                                        child: photoUrl != null
                                            ? Image.network(
                                          photoUrl!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.network(
                                            'https://via.placeholder.com/150'))
                                        : null,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: 820,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 7,
                          decoration: BoxDecoration(
                              color: Color(0xfff9b701),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                        ),
                        Positioned(
                          top: 40,
                          left: 15,
                          right: 15,
                          // child: Padding(
                          //   padding: const EdgeInsets.all(8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4.5,
                            decoration: BoxDecoration(
                              color: Color(0xff1c2229),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0.4,
                                  blurRadius: 10,
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 23,
                                                backgroundColor:
                                                    Color(0xff393939),
                                                child: Image.asset(
                                                  'assets/icons/transport.png',
                                                  scale: 7,
                                                ),
                                              ),
                                              onTap: () {
                                                print('transport');
                                              },
                                            ),
                                            Text('การขนส่ง',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt-Light',
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 1.0,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 2),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),

                                        ///การขนส่ง

                                        Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 23,
                                                backgroundColor:
                                                    Color(0xff393939),
                                                child: Image.asset(
                                                    'assets/icons/export.png',
                                                    scale: 7.5),
                                              ),
                                              onTap: () {
                                                print('export');
                                              },
                                            ),
                                            Text('การส่งออก',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt-Light',
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 1.0,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 2),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),

                                        ///การส่งออก
                                        Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 23,
                                                backgroundColor:
                                                    Color(0xff393939),
                                                child: Image.asset(
                                                    'assets/icons/new.png',
                                                    width: 43),
                                              ),
                                              onTap: () {
                                                print('new');
                                              },
                                            ),
                                            Text('ข่าวสาร',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt-Light',
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 1.0,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 2),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),

                                        ///ข่าวสาร
                                        Column(
                                          children: [
                                            GestureDetector(
                                              child: CircleAvatar(
                                                radius: 23,
                                                backgroundColor:
                                                    Color(0xff393939),
                                                child: Image.asset(
                                                    'assets/icons/group.png',
                                                    scale: 7),
                                              ),
                                              onTap: () {
                                                print('group');
                                              },
                                            ),
                                            Text('กลุ่ม',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt-Light',
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 1.0,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 2),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),

                                        ///กลุ่ม
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor:
                                                  Color(0xff393939),
                                              child: Image.asset(
                                                  'assets/icons/products.png',
                                                  scale: 7),
                                            ),
                                            onTap: () {
                                              print('products');
                                            },
                                          ),
                                          Text('สินค้า',
                                              style: TextStyle(
                                                fontFamily: 'Prompt-Light',
                                                fontSize: 10,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 1.0,
                                                    color: Colors.black54,
                                                    offset: Offset(1, 2),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),

                                      ///สินค้าเกษตร
                                      Column(
                                        children: [
                                          GestureDetector(
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor:
                                                  Color(0xff393939),
                                              child: Image.asset(
                                                  'assets/icons/tractor.png',
                                                  scale: 7.3),
                                            ),
                                            onTap: () {
                                              print('tractor');
                                            },
                                          ),
                                          Text('เครื่องจักร',
                                              style: TextStyle(
                                                fontFamily: 'Prompt-Light',
                                                fontSize: 10,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 1.0,
                                                    color: Colors.black54,
                                                    offset: Offset(1, 2),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),

                                      ///เครื่องจักร
                                      Column(
                                        children: [
                                          GestureDetector(
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor:
                                                  Color(0xff393939),
                                              child: Image.asset(
                                                  'assets/icons/fertilizer.png',
                                                  scale: 7),
                                            ),
                                            onTap: () {
                                              print('fertilizer');
                                            },
                                          ),
                                          Text('เคมีภัณฑ์',
                                              style: TextStyle(
                                                fontFamily: 'Prompt-Light',
                                                fontSize: 10,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 1.0,
                                                    color: Colors.black54,
                                                    offset: Offset(1, 2),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),

                                      ///ปุ๋ยและอาหารสัตว์
                                      Column(
                                        children: [
                                          GestureDetector(
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor:
                                                  Color(0xff393939),
                                              child: Image.asset(
                                                  'assets/icons/report.png',
                                                  scale: 7),
                                            ),
                                            onTap: () {
                                              print('report');
                                            },
                                          ),
                                          Text('งานวิจัย',
                                              style: TextStyle(
                                                fontFamily: 'Prompt-Light',
                                                fontSize: 10,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 1.0,
                                                    color: Colors.black54,
                                                    offset: Offset(1, 2),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),

                                      ///งานวิจัย
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //box2
                        ///พื้นที่โฆษณา
                        Positioned(
                          top: 230,
                          left: 7,
                          right: 7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height /7,
                            decoration: BoxDecoration(
                              //color: Color(0xff1c222b),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child:  Column(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 105.0,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.ease,
                                    pauseAutoPlayOnTouch: true,
                                    aspectRatio:2.8,
                                    viewportFraction: 0.98,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                  items: cardList.map((card){
                                    return Builder(
                                        builder:(BuildContext context){
                                          return Container(
                                            height: MediaQuery.of(context).size.height*0.38,
                                            width: MediaQuery.of(context).size.width,
                                            child: Card(
                                              color: Colors.blueAccent,
                                              child: card,
                                            ),
                                          );
                                        }
                                    );
                                  }).toList(),
                                ),

                              ],
                            ),

                          ),
                          ),

                        Positioned(
                          top: 340,
                          left: 8,
                          right: 8,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(cardList, (index, url) {
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index ? Colors.black : Colors.grey,
                              ),
                            );
                          }),
                        ),),

                        Positioned(
                            top: 350,
                            left: 8,
                            right: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ฟาร์มแนะนำ',
                                  style: TextStyle(
                                    fontFamily: 'Prompt-SemiBold',
                                    fontSize: 20,
                                    letterSpacing: 2,
                                    color: Color(0xfff2b202),
                                    shadows: [
                                      Shadow(
                                        blurRadius: 1.0,
                                        color: Colors.black54,
                                        offset: Offset(1, 2),
                                      ),
                                    ],
                                  )),
                            )),
                        Positioned(
                          top: 378,
                          left: 8,
                          right: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(2, 1, 0, 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                            width: 90,
                                            //height: 95,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Image.asset(
                                              'assets/icons/11222.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                            Text('ฟาร์มไก่',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt-Light',
                                                  fontSize: 10,
                                                  letterSpacing: 2,
                                                  color: Colors.white60,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 1.0,
                                                      color: Colors.black54,
                                                      offset: Offset(1, 2),
                                                    ),
                                                  ],
                                                )),]
                                        ),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 90,
                                                //height: 95,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20))),
                                                child: Image.asset(
                                                  'assets/icons/11222.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text('ฟาร์มวัวนม',
                                                  style: TextStyle(
                                                    fontFamily: 'Prompt-Light',
                                                    fontSize: 10,
                                                    letterSpacing: 2,
                                                    color: Colors.white60,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 1.0,
                                                        color: Colors.black54,
                                                        offset: Offset(1, 2),
                                                      ),
                                                    ],
                                                  )),]
                                        ),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 90,
                                                //height: 95,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20))),
                                                child: Image.asset(
                                                  'assets/icons/11222.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text('ฟาร์มแพะ',
                                                  style: TextStyle(
                                                    fontFamily: 'Prompt-Light',
                                                    fontSize: 10,
                                                    letterSpacing: 2,
                                                    color: Colors.white60,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 1.0,
                                                        color: Colors.black54,
                                                        offset: Offset(1, 2),
                                                      ),
                                                    ],
                                                  )),]
                                        ),Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 90,
                                                //height: 95,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20))),
                                                child: Image.asset(
                                                  'assets/icons/11222.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text('ไร่นาสวนผสม',
                                                  style: TextStyle(
                                                    fontFamily: 'Prompt-Light',
                                                    fontSize: 10,
                                                    letterSpacing: 2,
                                                    color: Colors.white60,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 1.0,
                                                        color: Colors.black54,
                                                        offset: Offset(1, 2),
                                                      ),
                                                    ],
                                                  )),]
                                        ),Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 90,
                                                //height: 95,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20))),
                                                child: Image.asset(
                                                  'assets/icons/11222.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text('แปลงผัก',
                                                  style: TextStyle(
                                                    fontFamily: 'Prompt-Light',
                                                    fontSize: 10,
                                                    letterSpacing: 2,
                                                    color: Colors.white60,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 1.0,
                                                        color: Colors.black54,
                                                        offset: Offset(1, 2),
                                                      ),
                                                    ],
                                                  )),]
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        //),
                        Positioned(
                            top: 490,
                            left: 8,
                            right: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('จัดอันดับราคา',
                                  style: TextStyle(
                                fontFamily: 'Prompt-SemiBold',
                                fontSize: 20,
                                letterSpacing: 2,
                                color: Color(0xfff2b202),
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.black54,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              )),
                            )),

                        ///จัดอันดับราคา
                        Positioned(
                          top: 528,
                          left: 8,
                          right: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 280,
                            decoration: BoxDecoration(
                              color: Color(0xff1c222b),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            provider.setNavigator(NavigatorItem.priceUp);
                                            onClick = true;
                                          });
                                        },
                                        child: Text(
                                          'ราคาขึ้น',
                                          style: TextStyle(
                                              fontFamily: 'Prompt-Light',
                                              fontSize: 18,
                                              color: onClick != false
                                                  ? Color(0xffffbb00)
                                                  : Colors.white),
                                        )
                                    ),
                                    Container(
                                      height: 15,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            provider.setNavigator(NavigatorItem.priceDown);
                                            onClick = false;
                                          });
                                        },
                                        child: Text('ราคาลง',
                                            style: TextStyle(
                                                fontFamily: 'Prompt-Light',
                                                fontSize: 18,
                                                color: onClick == false
                                                    ? Color(0xffffbb00)
                                                    : Colors.white))),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Divider(
                                    indent: 2,
                                    endIndent: 2,
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('ประเภท',
                                        style: TextStyle(
                                            fontFamily: 'Prompt-Light',
                                            fontSize: 12,
                                            color: Colors.white30)),
                                    Text('ราคาล่าสุด',
                                        style: TextStyle(
                                            fontFamily: 'Prompt-Light',
                                            fontSize: 12,
                                            color: Colors.white30)),
                                    Text('คิดเป็น % จากเมื่อวาน ',
                                        style: TextStyle(
                                            fontFamily: 'Prompt-Light',
                                            fontSize: 12,
                                            color: Colors.white30)),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                BuildPages()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CircleAvatar builddot1() {
    return CircleAvatar(
      radius: 6.5,
      backgroundColor: Colors.black38,
    );
  }

  CircleAvatar builddot2() {
    return CircleAvatar(
      radius: 6.5,
      backgroundColor: Colors.black,
    );
  }

  CircleAvatar builddot3() {
    return CircleAvatar(
      radius: 6.5,
      backgroundColor: Colors.black38,
    );
  }

  CircleAvatar builddot4() {
    return CircleAvatar(
      radius: 6.5,
      backgroundColor: Colors.black38,
    );
  }

  CircleAvatar builddot5() {
    return CircleAvatar(
      radius: 6.5,
      backgroundColor: Colors.black38,
    );
  }

Widget BuildPages() {

  final provider = Provider.of<NavigationProvider>(context);
  final navigationItems = provider.navigator;

  switch (navigationItems) {
    case NavigatorItem.priceUp:
      return buildPriceUp();
    case NavigatorItem.priceDown:
      return buildPriceDown();


  }
}

Container buildPriceUp(){
    return Container(
      width: 350,
      height: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Meat',
                    style: TextStyle(color: Colors.white)),
              ),
              Spacer(),
              Text('Last Price',
                  style: TextStyle(color: Colors.white)),
              Spacer(),
              Text('PercentageS',
                  style: TextStyle(color: Colors.white)),
              Spacer(),
            ],
          )
        ],
      ),
    );
}
Container buildPriceDown(){
    return Container(
      width: 350,
      height: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Superman',
                    style: TextStyle(color: Colors.white)),
              ),
              Spacer(),
              Text('Last Price',
                  style: TextStyle(color: Colors.white)),
              Spacer(),
              Text('PercentageS',
                  style: TextStyle(color: Colors.white)),
              Spacer(),
            ],
          )
        ],
      ),
    );
}

}



class Item1 extends StatelessWidget {
  const Item1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  "Hello",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                  )
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
            'assets/icons/k2.png',
            height: 95.0,
            fit: BoxFit.fill,
          );

  }
}

class Item4 extends StatelessWidget {
  const Item4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              "Data",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}