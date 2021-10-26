import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './user_fetch.dart';

class User with ChangeNotifier {
  List<UserInfo> _user = [];
  final String? authToken;
  final String? userId;

  User(this.authToken, this.userId);

  List<UserInfo> get user {
    return [..._user];
  }

  UserInfo userById(String id) {
    return _user.firstWhere((user) => user.userID == id);
  }

  Future<void> fetchUser() async {
    var url = Uri.parse(
        'https://shingrix-9d90f-default-rtdb.asia-southeast1.firebasedatabase.app/users.json?auth=$authToken');

    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;

      if (data == null) {
        return;
      }

      final List<UserInfo> loadedUser = [];

      data.forEach((userId, userData) {
        loadedUser.add(UserInfo(
          userID: userId,
          fname: userData['first_name'],
          lname: userData['last_name'],
          img: userData['img'],
        ));
      });

      _user = loadedUser;

      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
}
