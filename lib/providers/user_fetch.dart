import 'package:flutter/foundation.dart';

class UserInfo with ChangeNotifier {
  final String userID;
  final String fname;
  final String lname;
  final String img;

  UserInfo({
    required this.userID,
    required this.fname,
    required this.lname,
    required this.img,
  });
}
