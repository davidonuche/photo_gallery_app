import 'package:http/http.dart' as http;
import 'dart:convert';


class DataHttpException implements Exception {
  DataHttpException(this.statusCode);
  final int statusCode;

  @override
  String toString() {
    return 'DataHttpException: HTTP status code $statusCode';
  }
}

class NetworkHelper {
  NetworkHelper({required this.url});
  final String url;

  Future<dynamic> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      // means success
      if (response.statusCode == 200) {
       
        String data = response.body;
        // prases json string and return json object
        dynamic jsonObjects = jsonDecode(data);
        return jsonObjects;
      } else {
        
        throw DataHttpException(response.statusCode);
      }
    } catch (e) {
     
      rethrow;
    }
  }
}