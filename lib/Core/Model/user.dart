// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
     this.id,
     this.name,
     this.photo,
     this.age,
     this.email,
     this.address,
     this.password,
     this.follow,
     this.like,
     this.rate,
     this.status,
     this.createdDate,
     this.v,
  });

  String? id;
  String? name;
  String? photo;
  String? age;
  String? email;
  String? address;
  String? password;
  String? follow;
  String? like;
  String? rate;
  String? status;
  DateTime? createdDate;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
    age: json["age"] == null ? null : json["age"],
    email: json["email"] == null ? null : json["email"],
    address: json["address"] == null ? null : json["address"],
    password: json["password"] == null ? null : json["password"],
    follow: json["follow"] == null ? null : json["follow"],
    like: json["like"] == null ? null : json["like"],
    rate: json["rate"] == null ? null : json["rate"],
    status: json["status"] == null ? null : json["status"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "photo": photo == null ? null : photo,
    "age": age == null ? null : age,
    "email": email == null ? null : email,
    "address": address == null ? null : address,
    "password": password == null ? null : password,
    "follow": follow == null ? null : follow,
    "like": like == null ? null : like,
    "rate": rate == null ? null : rate,
    "status": status == null ? null : status,
    "createdDate": createdDate == null ? null : createdDate.toString(),
    "__v": v == null ? null : v,
  };
}
