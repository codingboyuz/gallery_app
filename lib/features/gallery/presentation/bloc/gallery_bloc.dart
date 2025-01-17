import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/my_library.dart';

// GalleryBloc - galereya ekranidagi media aktivlarini boshqaruvchi BLoC
class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final MediaAssetsUseCase mediaAssetsUseCase; // Media aktivlarini olish uchun xizmat

  // Konstruktor orqali MediaAssetsUseCase'ni yuborib, bosh holat sifatida GalleryInitial o'rnatiladi
  GalleryBloc({
    required this.mediaAssetsUseCase,
  }) : super(GalleryInitial()) {
    // Bloc qanday eventlarni kutishini va ularning bajarilishini belgilash
    on<GetMediaAssetsEvent>(_getAssets); // GetMediaAssetsEvent kelganda _getAssets metodini chaqirish
  }

  // Media aktivlarini olish uchun ishlatiladigan metod
  Future<void> _getAssets(
      GetMediaAssetsEvent event, Emitter<GalleryState> emit) async {
    try {
      // Yuklanayotgan holatni yuborish
      emit(GalleryLoading());

      // Media aktivlarini olish uchun use case'ni chaqirish
      final result = await mediaAssetsUseCase.call(NoParams());

      // Natijani tekshirish
      result.fold(
            (failure) {
          // Agar xato bo'lsa, GalleryError holatini yuborish
          emit(GalleryError(failure.message));
        },
            (response) {
          // Agar muvaffaqiyatli bo'lsa, GallerySuccess holatini yuborish
          emit(GallerySuccess(response)); // Rasm fayllari muvaffaqiyatli yuklandi
        },
      );
    } catch (e) {
      // Agar hatolik yuzaga kelsa, xatoni qaytarish
      emit(GalleryError(e.toString()));
    }
  }
}
