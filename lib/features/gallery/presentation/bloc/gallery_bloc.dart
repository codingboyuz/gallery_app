import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/my_library.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final MediaAssetsUseCase mediaAssetsUseCase;


  GalleryBloc({
    required this.mediaAssetsUseCase,

  }) : super(GalleryInitial()) {
    // Bu qator Bloc qanday eventlarni kutishini va bu eventlar kelganda qanday logikani bajarishini belgilaydi.
    on<GetMediaAssetsEvent>(_getAssets);
  }


  Future<void> _getAssets(
      GetMediaAssetsEvent event, Emitter<GalleryState> emit) async {
    try {
      emit(GalleryLoading());
      final result = await mediaAssetsUseCase.call(NoParams());
      result.fold((failure) {
        emit(GalleryError(failure.message));
      }, (response) {
        emit(GallerySuccess(
            response)); // Rasm fayllari muvaffaqiyatli yuklandi
      });
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }





}
