import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Document with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int views;
  final int rating;
  // final String url;
  final List img;
  bool inBriefcase;

  Document({
    required this.id,
    required this.title,
    required this.description,
    required this.views,
    required this.rating,
    // required this.url,
    required this.img,
    this.inBriefcase = false,
  });

  void _saveDocValue(bool newValue) {
    inBriefcase = newValue;
    notifyListeners();
  }

  Future<void> toggleSaveStatus(String token, String userId) async {
    final oldStatus = inBriefcase;
    inBriefcase = !inBriefcase;
    notifyListeners();
    final url = Uri.parse(
        'https://shingrix-9d90f-default-rtdb.asia-southeast1.firebasedatabase.app/userBriefcase/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(
          inBriefcase,
        ),
      );
      if (response.statusCode >= 400) {
        _saveDocValue(oldStatus);
      }
    } catch (error) {
      _saveDocValue(oldStatus);
    }
  }
}
