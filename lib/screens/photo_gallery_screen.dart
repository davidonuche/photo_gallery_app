import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = context.watch<List<String>>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
            ),
            itemBuilder: (context, index) {
              return Image.network(images[index], fit: BoxFit.cover);
            },
          ),
        ),
      ),
    );
  }
}
