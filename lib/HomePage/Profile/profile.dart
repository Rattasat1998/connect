import 'dart:convert';
import 'dart:io';
import 'package:connnection/Core/Model/user.dart';
import 'package:connnection/LoginPage/Provider_User.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Profile extends StatefulWidget {
  final String? name, address, id;

  const Profile({Key? key, this.name, this.address, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /// HTTP
  late final MyProvider myProvider;
  Dio dio = new Dio();
  late final String? name, address;

  /// IMAGE
  final _picker = ImagePicker();
  late PickedFile pickedFile;
  File? image;
  var resultImage;

  ///USER
  User user = User();
  bool isLoading = false;

  bool scroll = false;
  int speedFactor = 20;

  @override
  void initState() {
    //myProvider = Provider.of<MyProvider>(context, listen: false);
    getUsers();
    // TODO: implement initState
    super.initState();
  }

  Future updateImage() async {
    print('Need to Update this : => $resultImage' + 'to go ${widget.id}');
    await dio.post(
      'https://connectiondatabase12.herokuapp.com/api/user/updateUser/${widget.id}',
      data: {"photo": resultImage},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    setState(() {
      print('Updated Image Success!! ... ');
      getUsers();
    });
  }

  Future<User?> getUsers() async {
    final response = await http
        .get(Uri.parse('https://connectiondatabase12.herokuapp.com/api/user/${widget.id}'));
    user = userFromJson(response.body);
    print(user.name);

    return user;
  }

  _imgFromCamera() async {
    final PickedFile? pickedFile =
    await _picker.getImage(source: ImageSource.camera);

    setState(() {
      final File _image = File(pickedFile!.path);
      image = _image;
      //upload(_image);
    });
  }

  _imgFromGallery() async {
    final PickedFile? pickedFile = await _picker.getImage(
        source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);

    setState(() {
      final File _image = File(pickedFile!.path);
      image = _image;
      //upload(_image);
    });
  }

  upload(File imageFile) async {
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://connectiondatabase12.herokuapp.com/upload");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('myFile', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    print('Uploading ...');
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      setState(() {
        resultImage = jsonDecode(value);
      });
    });
    updateImage();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('แกลเลอรี่'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('กล้อง'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'บัญชีผู้ใช้',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2),
              ),
            ),
            FutureBuilder(
                future: getUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var result = snapshot.data;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                "${result.name}",
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
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            LineIcons.mapMarker,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            '${result.address}',
                                                            style: GoogleFonts.lato(
                                                                textStyle:
                                                                Theme.of(context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontStyle:
                                                                FontStyle.normal,
                                                                color: Colors.black ,
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
                                                      child: result.photo == null
                                                          ? Placeholder()
                                                          : Image.network(
                                                        "https://picsum.photos/200/100?grayscale",
                                                        //"https://connectiondatabase12.herokuapp.com/${result.photo}",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 1, 8, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    height: MediaQuery.of(context).size.height/18,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
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
                                                ' Email : ${result.email}',
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
                                    width: MediaQuery.of(context).size.width/2.5,
                                    height: MediaQuery.of(context).size.height/18,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
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
                                                        '${result.like}',
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
                                                        '${result.follow}',
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
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'การตั้งค่า',
                                    style: GoogleFonts.lato(
                                        textStyle:
                                        Theme.of(context).textTheme.bodyText1,
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
                                    color: Colors.black54,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'V.10.0.3 (เสถียร)',
                                                  style: GoogleFonts.lato(
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'ไทย',
                                                  style: GoogleFonts.lato(
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '${result.status}',
                                                  style: GoogleFonts.lato(
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'เปิดใช้งาน',
                                                  style: GoogleFonts.lato(
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                        textStyle:
                                        Theme.of(context).textTheme.bodyText1,
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
                                    color: Colors.black54,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                        textStyle:
                                        Theme.of(context).textTheme.bodyText1,
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
                                    color: Colors.black54,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                      fontSize: 16,
                                                      fontStyle: FontStyle.normal,
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
                                    },
                                    child: Text('ออกจากระบบ',
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                          letterSpacing: 1),)
                                ),
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
                                  Text('การเข้าสู่ระบบครั้งถัดไปจะถูกบันทึกไว้ใน',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        letterSpacing: 1),),
                                  TextButton(onPressed: (){}, child: Text('ประวัติการเข้าสู่ระบบ',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.blue,
                                        letterSpacing: 1),)),
                                  Text('โปรดระวัง',
                                    style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        letterSpacing: 1),),
                                ],
                              ),
                              Text('เปลี่ยนรหัสผ่านบ่อยครั้งดเพื่อป้องกันการโจรกรรมบัญชีของคุณ',
                                style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1,
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                    letterSpacing: 1),),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return LinearProgressIndicator();
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
