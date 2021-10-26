import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/user.dart';

class UserProfileHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final user = Provider.of<User>(context, listen: false)
        .userById(authData.userId.toString());

    return Column(
      children: <Widget>[
        Container(
          padding: new EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 55.0,
            backgroundImage: NetworkImage("${user.img}"),
            backgroundColor: Colors.black45,
          ),
        ),
        Container(
          padding: new EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Text(user.fname + ' ' + user.lname),
        ),
      ],
    );
  }
}
