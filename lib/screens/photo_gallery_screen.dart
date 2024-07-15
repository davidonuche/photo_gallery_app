import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gallery_controller.dart';

class PhotoGalleryScreen extends StatelessWidget {
  PhotoGalleryScreen({super.key});

  final GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Obx(() {
            if (controller.status.value == GalleryStatus.loading &&
                controller.images.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.status.value == GalleryStatus.loaded ||
                (controller.status.value == GalleryStatus.loading &&
                    controller.images.isNotEmpty)) {
              return GridView.builder(
                itemCount: controller.images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.network(
                              controller.images[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      controller.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }
            if (controller.status.value == GalleryStatus.error) {
              return Center(
                child: Text('Failed to load images'),
              );
            }
            return Container();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.loadMore();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}