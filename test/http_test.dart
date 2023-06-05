import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'src/mock_data_provider.dart';

void main() {
  test("Fetch first image", () async {
    final MockDataProvider mockDataProvider = MockDataProvider();
    mockDataProvider.client = MockClient((request) async {
      final jsonMap = {
        "total": 1410253,
        "totalHits": 500,
        "hits": [
          {
            "largeImageURL":
                "https://pixabay.com/get/g17779e774c27ddf62ffe201b417c86d86dff0b67a434d30eee865dcd4420ff1182569b832ecf75513ece02c43d3791509808d1f2783f275dfe5400f9297638ff_1280.jpg",
          },
          {
            "largeImageURL":
                "https://pixabay.com/get/g2f4e1c4636739c3b6e22f26057ddf681495addce88735a6a609278da1548ff620b38641fbc2f32b395a9ee219093a787d5038f15420693afa40a1b1c4f74587a_1280.jpg",
          },
          {
            "largeImageURL":
                "https://pixabay.com/get/g09fab29d72c6e696da65fd2fcd88e6faed74ae1e775303fbccaa43a81cd2e6ce8a46a9b966ba01035188dcd4a7cdc020bed3cf32e5bd9c5326269b3d516ffb4c_1280.jpg",
          }
        ]
      };
      return Response(json.encode(jsonMap), 200);
    });
    final _data = await mockDataProvider.getData();
    String firstimage = _data["hits"][0]["largeImageURL"];
    expect(
      firstimage,
      "https://pixabay.com/get/g17779e774c27ddf62ffe201b417c86d86dff0b67a434d30eee865dcd4420ff1182569b832ecf75513ece02c43d3791509808d1f2783f275dfe5400f9297638ff_1280.jpg",
    );
  });
  test("First data returns exception", () async {
    final MockDataProvider mockDataProvider = MockDataProvider();
    mockDataProvider.client = MockClient((request) async {
      return Response(json.encode(""), 404);
    });
    try {
      mockDataProvider.getData();
    } on TestDataHttpException catch (error) {
      expect(error.statusCode, 404);
    }
  });
}
