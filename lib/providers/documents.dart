import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './doc_item.dart';

class Documents with ChangeNotifier {
  List<Document> _files = [];

  final String? authToken;
  final String? userId;

  Documents(this.authToken, this.userId, this._files);

  List<Document> get files {
    return [..._files];
  }

  List<Document> get savedItems {
    return _files.where((fileItem) => fileItem.inBriefcase).toList();
  }

  Document findById(String id) {
    return _files.firstWhere((file) => file.id == id);
  }

  Future<void> fetchAndSetFiles() async {
    var url = Uri.parse(
        'https://shingrix-9d90f-default-rtdb.asia-southeast1.firebasedatabase.app/files.json?auth=$authToken');

    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;

      if (data == null) {
        return;
      }

      url = Uri.parse(
          'https://shingrix-9d90f-default-rtdb.asia-southeast1.firebasedatabase.app/userBriefcase/$userId.json?auth=$authToken');
      final savedDocRes = await http.get(url);
      final savedDocData = json.decode(savedDocRes.body);
      final List<Document> loadedFiles = [];

      data.forEach((fileId, fileData) {
        loadedFiles.add(Document(
          id: fileId,
          title: fileData['title'],
          description: fileData['description'],
          views: fileData['views'],
          rating: fileData['rating'],
          img: fileData['img'],
          inBriefcase:
              savedDocData == null ? false : savedDocData[fileId] ?? false,
        ));
      });
      _files = loadedFiles;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
}
