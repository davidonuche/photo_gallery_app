import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String pixabayApiKey = "29058379-bae466c042e6a761694bdc488";
const String pixabayBaseUrl = "https://pixabay.com/api/";

enum GalleryStatus { loading, loaded, error }

class GalleryController extends GetxController {
  var images = <String>[].obs;
  var status = GalleryStatus.loading.obs;
  int currentPage = 1;
  int initialLoadCount = 20;
  int subsequentLoadCount = 20;
  bool isLoadingMore = false;

  @override
  void onInit() {
    super.onInit();
    fetchImages(initialLoadCount);
  }

  void fetchImages(int count) async {
    status.value = GalleryStatus.loading;
    try {
      final response = await http.get(Uri.parse(
          '$pixabayBaseUrl?key=$pixabayApiKey&q=nature&image_type=photo&per_page=$count&page=$currentPage'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final imageList = jsonResponse['hits'] as List;
        images.addAll(
            imageList.map((image) => image['webformatURL'] as String).toList());
        status.value = GalleryStatus.loaded;
        print("Images fetched: ${images.length}");
      } else {
        status.value = GalleryStatus.error;
        print("Failed to load images: ${response.statusCode}");
      }
    } catch (e) {
      status.value = GalleryStatus.error;
      print("Error fetching images: $e");
    }
  }

  void loadMore() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    currentPage++;
    fetchImages(subsequentLoadCount);
    isLoadingMore = false;
  }
}
