// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class DashBoardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        bottomOpacity: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => Column(
            children: <Widget>[
              const Text('Dashboard Screen Here!'),
              FlatButton(
                child: const Text('Logout'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
