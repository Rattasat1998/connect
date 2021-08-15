
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService{
  static final AuthService _apiService = AuthService._init();

  factory AuthService() {

    return _apiService;
  }

  AuthService._init();
  Dio dio = new Dio();

  login(email,password) async {
    try{
      return await dio.post('https://connectiondatabase12.herokuapp.com/api/user/auth', data: {
        "email":email,
        "password":password,
      }, options:Options(contentType: Headers.formUrlEncodedContentType)
      );
    }
    on DioError catch(e) {
      Fluttertoast.showToast(msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }
  /// ,follow,like,rate,status,age,address
  addUser(username,photo,age,email,address,password,follow,like,rate,status) async {
    await dio.post('https://connectiondatabase12.herokuapp.com/api/user/addNewUser',
      data: {
        "name":username,
        "photo":photo,
        "age":age,
        "email":email,
        "address":address,
        "password":password,
        "follow":follow,
        "like":like,
        "rate":rate,
        "status":status,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),

    );
  }

  getProfile(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('https://connectiondatabase12.herokuapp.com/api/user/getprofile/profile/myprofile');
  }

}