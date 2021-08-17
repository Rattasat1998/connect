import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Future<bool> onBackPress() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: Color(0xff1c2229),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
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
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              "https://picsum.photos/200/100?grayscale",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                            height: MediaQuery.of(context).size.height / 7,
                            width: 170,
                            child: Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                              child: Container(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Rattasat Phabsing',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('ออนไลน์',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white))
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.dehaze,
                                      color: Colors.white,
                                      size: 29,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildListMessage(),
            buildInput()
          ],
        ),
      ),
    ));
  }

  Widget buildInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Button send image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 350,
              height: 45,
              child: Row(
                children: [
                  // Edit text
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white30),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onSubmitted: (value) {},
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            hintText: 'พิมพ์ข้อความ',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                // child: IconButton(
                                //   icon: Icon(
                                //     Icons.camera_alt,color: Colors.black,
                                //   ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   child: IconButton(
                  //       icon: Icon(Icons.thumb_up_alt_rounded,color: Colors.yellow,),
                  //       onPressed: () {}
                  //   ),
                  // ),
                  // // Button plus
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(32),
                  //       color: Colors.white),
                  //     child: IconButton(
                  //         icon: Icon(Icons.add),
                  //         onPressed: () {}
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5)), color: Colors.black87),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO Left Message
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      "https://picsum.photos/200/100?grayscale",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text('Hello Boy'),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black12),
                      margin: EdgeInsets.only(left: 10.0),
                    )),
                Container(
                  child: Text(
                    '12:00',
                    style:
                        TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
                  ),
                  margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                )
              ],
            ),
            // TODO Right Message
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// Time
                Container(
                  child: Text(
                    '12:05',
                    style:
                        TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
                  ),
                  margin: EdgeInsets.only(right: 5.0, top: 5.0, bottom: 5.0),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text('Hello Girl'),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black12),
                      margin: EdgeInsets.only(left: 10.0),
                    )),
                CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      "https://picsum.photos/200/100?grayscale",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
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
}
