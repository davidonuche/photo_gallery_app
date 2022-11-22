import 'package:http/http.dart' as http;
import 'package:photo_gallery_app/services/keys.dart';
import 'dart:convert';

import 'package:photo_gallery_app/services/models/photos_model.dart';

class NetworkHelper {
  NetworkHelper({required this.url});
  final String url;
  Future<dynamic> getData() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    // Means success
    if (response.statusCode == 200) {
      // Json
      String data = response.body;
      // Parses jason string and returns jsonObjects
      dynamic jsonObjects = jsonDecode(data);
      print(jsonObjects(data));
      return jsonObjects;
    } else {
      print(response.statusCode);
    }
  }

  static Future<PhotosModel> getPhotos() async {
    try {
      final response = await http.get(Uri.parse(
          "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=nature&page-1"));
      if (response.statusCode == 200) {
        PhotosModel photo = photosModelFromJson(response.body);
        
        return PhotosModel(
            hits: photo.hits, total: photo.total, totalHits: photo.totalHits);
      } else {
        return PhotosModel();
      }
    } catch (e) {
      rethrow;
    }
  }
}
