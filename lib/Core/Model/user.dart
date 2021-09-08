import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.age,
    required this.email,
    required this.address,
    required this.password,
    required this.follow,
    required this.like,
    required this.rate,
    required this.status,
    required this.createdDate,
  });

  late String id;
  late String name;
  late String photo;
  late String age;
  late String email;
  late String address;
  late String password;
  late String follow;
  late String like;
  late String rate;
  late String status;
  late String createdDate;

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    String name = "";
    String photo = "";
    String age = "";
    String email = "";
    String address = "";
    String password = "";
    String follow = "";
    String like = "";
    String rate = "";
    String status = "";
    String createdDate = "";
    try {
      name = doc.get('name');
    } catch (e) {}
    try {
      photo = doc.get('photo');
    } catch (e) {}
    try {
      age = doc.get('age');
    } catch (e) {}
    try {
      email = doc.get('email');
    } catch (e) {}
    try {
      address = doc.get('address');
    } catch (e) {}
    try {
      password = doc.get('password');
    } catch (e) {}
    try {
      follow = doc.get('follow');
    } catch (e) {}
    try {
      like = doc.get('like');
    } catch (e) {}
    try {
      rate = doc.get('rate');
    } catch (e) {}
    try {
      status = doc.get('status');
    } catch (e) {}
    try {
      createdDate = doc.get('createdDate');
    } catch (e) {}

    return UserModel(
      id: doc.id,
      name: name,
      photo: photo,
      age: age,
      email: email,
      address: address,
      password: password,
      follow: follow,
      like: like,
      rate: rate,
      status: status,
      createdDate: createdDate,
    );
  }
/*
  UserModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    photo = data["photo"];
    age = data["age"];
    email = data["email"];
    address = data["address"];
    password = data["password"];
    follow = data["follow"];
    like = data["like"];
    rate = data["rate"];
    status = data["status"];
    createdDate = data["createdDate"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "photo": photo,
      "age": age,
      "email": email,
      "address": address,
      "password": password,
      "follow": follow,
      "like": like,
      "rate": rate,
      "status": status,
      "createdDate": createdDate,
    };
  }*/
}
