import 'package:http/http.dart' as http;
import 'dart:convert';

// Custom exception for HTTP errors
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

      // Check for success
      if (response.statusCode == 200) {
        // Parse the JSON data
        String data = response.body;
        dynamic jsonObjects = jsonDecode(data);
        return jsonObjects;
      } else {
        // Throw custom exception if not successful
        throw DataHttpException(response.statusCode);
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      rethrow;
    }
  }
}