import 'package:http/http.dart' as http;
import 'dart:convert';

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
      return jsonObjects(data);
    } else {
      print(response.statusCode);
    }
  }
}