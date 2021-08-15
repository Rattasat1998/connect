import 'package:connnection/HomePage/Index/Chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Index1 extends StatefulWidget {
  const Index1({Key? key}) : super(key: key);

  @override
  _Index1State createState() => _Index1State();
}

class _Index1State extends State<Index1> {
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
                color: Color(0xff1c2229),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: CircleAvatar(
                                radius: 17,
                                backgroundColor: Color(0xff393939),
                                backgroundImage: NetworkImage(
                                    'https://scontent.fkkc4-1.fna.fbcdn.net/v/t1.15752-9/232118994_867360260654577_9147289795008831810_n.png?_nc_cat=107&ccb=1-4&_nc_sid=ae9488&_nc_eui2=AeF5CP4YDCRrOtwjSE2CuPyu9dTVDuFfmhz11NUO4V-aHF2Jn2hy-Xc7G9y4IVp9SFOaXJSilvhLRVSuLZfzKtOB&_nc_ohc=PwtFbE3Ybr0AX8JgDFT&_nc_ht=scontent.fkkc4-1.fna&oh=00a717db584a645ca17dc20375a5b9ec&oe=61353867'),
                                //backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(32.0)),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  //controller: emailController,
                  onChanged: (value) {
                    //email = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xff4a4a4a),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(50, 12, 50, 10),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                    hintText: 'ค้นหา',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    )),
                child: Column(
                  children: [
                    Card(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => Chat()),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 32,
                            child: ClipOval(
                              child: Image.network(
                                "https://picsum.photos/200/100?grayscale",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            'Rattasat Phabsing',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text("Second One \n${18.011111} "),
                          isThreeLine: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
