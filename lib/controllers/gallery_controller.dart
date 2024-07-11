// controllers/gallery_controller.dart
import 'package:get/get.dart';
import 'package:photo_gallery_app/keys.dart';
import '../services/network_helper.dart';

enum GalleryStatus {
  loading,
  initial,
  loaded,
  error,
}

class GalleryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getImages();
  }

  GalleryStatus status = GalleryStatus.initial;
  int _page = 1;
  final List<String> _images = [];

  List<String> get images => _images;
  int get photoCount => _images.length;

  Future<void> getImages() async {
    await _fetchImages(reset: true);
  }

  Future<void> loadMore() async {
    await _fetchImages(reset: false);
  }

  Future<void> _fetchImages({required bool reset}) async {
    status = GalleryStatus.loading;
    update();
    
    if (reset) {
      _page = 1;
      _images.clear();
    } else {
      _page++;
    }

    String url = 'https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=nature&page=$_page';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    try {
      Map<String, dynamic> data = await networkHelper.getData();
      List<String> pixabyImages = List<String>.from(data["hits"].map((entry) => entry["largeImageURL"]));

      _images.addAll(pixabyImages);
      status = GalleryStatus.loaded;
    } catch (e) {
      status = GalleryStatus.error;
      Get.snackbar('Error', 'Failed to load images');
    }

    update();
  }
}