import 'package:get/get.dart';

import '../keys.dart';
import '../services/network_helper.dart';

class GalleryController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getImages();
  }

  int _page = 1;

  List<String> _images = [];

  List<String> get images => _images;

  int get photoCount => _images.length;

  Future<void> getImages() async {
    List<String> pixabyImages = [];

    String url =
        "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category==nature&page=$_page";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();
    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }
    _images = pixabyImages;
    update();
  }

  Future<void> loadMore() async {
    List<String> pixabyImages = [];

    String url =
        "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category==nature&page=${_page + 1}";
    _page++;
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();
    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }
    _images.addAll(pixabyImages);
    update();
  }
}
