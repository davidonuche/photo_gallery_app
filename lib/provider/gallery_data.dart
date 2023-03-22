import '../keys.dart';
import '../services/network_helper.dart';

class GalleryData {
  //Future<List<String>>? _images;
  //List<String> get images => [..._images];
  //int get imagesCount =>  _images.length;
  

  Future<List<String>> getImagesFromPixaby() async {
    List<String> pixabyImages = [];

    String url =
        "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category==nature&page=1";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();
    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }
    return pixabyImages;
  }
}
