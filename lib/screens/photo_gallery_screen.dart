import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_app/bloc/gallery_cubit.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BlocBuilder<GalleryCubit, GalleryState>(
            builder: (context, state) {
              if (state is GalleryLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GalleryLoaded) {
                return GridView.builder(
                  itemCount: state.images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(state.images[index],
                        fit: BoxFit.cover);
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
