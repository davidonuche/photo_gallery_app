import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/photo_gallery_screen.dart';
import 'controllers/audio_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());
    audioController.play();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PhotoGalleryScreen(),
    );
  }
}