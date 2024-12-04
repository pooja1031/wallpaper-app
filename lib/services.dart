import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/photomodel.dart';

class PhotosProvider extends ChangeNotifier {
  final List<Photo> _photos = [];
  int _page = 1;
  bool _isLoading = false;

  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;

  Future<void> fetchPhotos() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.unsplash.com/photos/?client_id=LgHVjxV5bkwbZU8a5o37bjhcm2FdI9Cj88PE5OT5zss&page=$_page&per_page=20');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Photo> newPhotos = data.map((json) => Photo.fromJson(json)).toList();
      _photos.addAll(newPhotos);
      _page++;
    } else {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }
}