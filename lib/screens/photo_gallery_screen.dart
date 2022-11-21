import 'package:flutter/material.dart';
import 'package:photo_gallery_app/services/keys.dart';
import 'package:photo_gallery_app/services/network_helper.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  List<String>? images;
  Future<List<String>?> getImagesFromPixaby() async {
    List<String> pixabyImages = [];
    String url =
        "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=nature&page-1";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();
    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }

    // String image = data["hits"][0]["largeImageURL"];
    // pixabyImages.add(image);
    return pixabyImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: 36,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
            ),
            itemBuilder: (context, index) {
              return Image.network(
                "https://placeimg.com/640/480/any",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
