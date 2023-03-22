import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../keys.dart';
import '../services/network_helper.dart';
part  "gallery_state.dart";

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  Future<void> getImagesFromPixaby() async {
    emit(GalleryLoading());
    //
    List<String> pixabyImages = [];

    String url =
        "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category==nature&page=1";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map<String, dynamic> data = await networkHelper.getData();
    for (var entry in data["hits"]) {
      pixabyImages.add(entry["largeImageURL"]);
    }
    //
     emit(GalleryLoaded(images: pixabyImages));
    
  }
}
