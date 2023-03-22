part of "gallery_cubit.dart";

abstract class GalleryState extends Equatable {
  GalleryState();
  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {
  GalleryInitial();
}

class GalleryLoading extends GalleryState {
  GalleryLoading();
}

class GalleryLoaded extends GalleryState {
  final List<String> images;
  GalleryLoaded({required this.images});
  @override
  List<Object> get props => [];
}
