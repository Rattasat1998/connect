import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({Key? key, this.result,})
      : super(key: key);
  final result;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: ClipOval(
                child: ClipOval(
                    child: Container(
                      height: 400.0,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(32.0),
                        child: Image.network(
                          result['photo'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ))),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black,
                size: 20,
              )),
        ),

      ],
    );
  }
}
