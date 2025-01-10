import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/my_library.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final MediaAssetsUseCase mediaAssetsUseCase;
  final MediaAlbumsUseCase mediaAlbumsUseCase;

  GalleryBloc(
      {required this.mediaAssetsUseCase, required this.mediaAlbumsUseCase})
      : super(GalleryInitial()) {
    on<GetMediaAlbumsEvent>(getAlbums);
    on<GetMediaAssetsEvent>(getAssets);
  }

  Future<void>? getAlbums(
      GalleryEvent event, Emitter<GalleryState> emit) async {
    try {
      final result = await mediaAlbumsUseCase.call(NoParams());
      result.fold((failure) {
        emit(GalleryError(failure.message));
      }, (response) {
        emit(GallerySuccess(response));
      });
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }
  // Blocda GetMediaAssetsEvent ni ishlatish
  Future<void> getAssets(
      GetMediaAssetsEvent event, Emitter<GalleryState> emit) async {
    try {
      emit(GalleryLoading());
      final result = await mediaAssetsUseCase.call(event.selectedAlbum);
      result.fold((failure) {
        emit(GalleryError(failure.message));
      }, (response) {
        emit(GalleryAssetsSuccess(response));  // Rasm fayllari muvaffaqiyatli yuklandi
      });
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }

}
