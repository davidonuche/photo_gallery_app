import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery_app/controllers/gallery_controller.dart';

class PhotoGalleryScreen extends StatelessWidget {
 PhotoGalleryScreen({super.key}) {
 Get.put(GalleryController());
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: GetBuilder<GalleryController> (
            builder: (controller) {
              return GridView.builder(
                  itemCount: controller.images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(controller.images[index],
                        fit: BoxFit.cover);
                  },
                );
            }
          ),
        ),
      ),
    );
  }
}