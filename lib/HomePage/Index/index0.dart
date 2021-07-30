import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Index0 extends StatefulWidget {
  const Index0({Key? key}) : super(key: key);

  @override
  _Index0State createState() => _Index0State();
}

class _Index0State extends State<Index0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Connection',
                        style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 3),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black26,
                              child: Icon(
                                Icons.search,
                                color: Colors.black87,
                              )),
                          CircleAvatar(
                              radius: 15,
                              child: Icon(
                                Icons.notifications,
                                color: Colors.black87,
                                size: 30,
                              )),
                          Container(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/03/26/09/41/tie-690084_960_720.jpg'),
                              backgroundColor: Colors.transparent,
                            ),
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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 7,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                        ),
                        Positioned(
                            top: 40,
                            left: 8,
                            right: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 4.5,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: GridView.count(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 2,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2016/04/30/08/35/aircraft-1362586__340.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Transport',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2018/01/30/13/28/container-3118783__340.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Export',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2014/07/01/12/35/taxi-381233__340.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'News',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2016/12/19/10/16/hands-1917895__340.png'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Groups',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2014/10/22/16/39/tools-498202__340.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Equipment',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2017/04/02/09/08/bulldozer-2195329__340.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Machinery',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2015/05/14/02/22/soil-766281__340.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Fertilizer',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 27,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      'https://cdn.pixabay.com/photo/2015/11/19/21/10/glasses-1052010__480.jpg'),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  'Research',
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
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                        Positioned(
                            top: 250,
                            left: 8,
                            right: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                MediaQuery.of(context).size.height / 9,
                                decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )),
                              ),
                        )),
                        Positioned(
                          top: 370,
                          left: 8,
                          right: 8,
                          child: Row(
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

}
