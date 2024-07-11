import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gallery_controller.dart';

class PhotoGalleryScreen extends StatelessWidget {
  PhotoGalleryScreen({super.key});

  final GalleryController galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: GetBuilder<GalleryController>(
            builder: (controller) {
              if (controller.status == GalleryStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.status == GalleryStatus.loaded) {
                return GridView.builder(
                  itemCount: controller.images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(controller.images[index], fit: BoxFit.cover);
                  },
                );
              }
              if (controller.status == GalleryStatus.error) {
                return Center(
                  child: Text('Failed to load images'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          galleryController.loadMore();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}