import 'package:flutter/material.dart';
import 'package:photo_gallery_app/provider/gallery_data.dart';
import 'package:provider/provider.dart';
import 'screens/photo_gallery_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<String>>(
      initialData: <String>[],
      create: (context) {
        GalleryData galleryData = GalleryData();
        return galleryData.getImagesFromPixaby();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: PhotoGalleryScreen(),
      ),
    );
  }
}

