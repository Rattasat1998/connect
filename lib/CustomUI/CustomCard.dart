import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, this.name, this.status, this.time})
      : super(key: key);
  final String? name, status,time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[200],
              radius: 23,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  )),
            )
          ],
        ),
      ),
      title: Text('$name',style: TextStyle(color: Colors.white70,fontSize: 18),),
      subtitle: Text('$status',style: TextStyle(color: Colors.white70),),
      trailing: Text('$time',style: TextStyle(color: Colors.white70),),
    );
  }
}
