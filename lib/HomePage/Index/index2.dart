/*
import 'dart:convert';

import 'package:connnection/Core/Model/ChatModel.dart';
import 'package:connnection/Core/Model/NewUser.dart';
import 'package:connnection/Core/Model/userList.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'Chat/test_chat.dart';

class AllChatsPage extends StatefulWidget {
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
  }
  List<UserList>? listUser = <UserList>[];
  Future<List<UserList>?> getUsers() async {
    // 192.168.3.38 for android (ip4)
    final response = await http
        .get(Uri.parse('http://192.168.3.38:3000/api/user/getallprofile/all'));
    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(response.body);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            setState(() {
              listUser!.add(UserList.fromJson(map));
            });
          }
        }
      }
      return listUser;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void friendClicked(UserList friend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatPage(friend);
        },
      ),
    );
  }

  Widget buildAllChatList() {
    return ListView.builder(
          itemCount: listUser!.length,
          itemBuilder: (BuildContext context, int index) {
            UserList friend = listUser![index];
            return ListTile(
              title: Text(friend.name),
              onTap: () => friendClicked(friend),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Chats'),
      ),
      body: buildAllChatList(),
    );
  }
}*/
