import 'package:flutter/material.dart';
import 'package:photo_gallery_app/services/keys.dart';
import 'package:photo_gallery_app/services/models/photos_model.dart';
import 'package:photo_gallery_app/services/network_helper.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  Future<PhotosModel>? _fetchPhoto;

  @override
  void initState() {
    super.initState();
    _fetchPhoto = NetworkHelper.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: _fetchPhoto,
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(child: Text("Error"));
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return GridView.builder(
                    itemCount: snapshot.data!.hits!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(
                        snapshot.data!.hits![index].previewUrl!,
                        fit: BoxFit.cover,
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
