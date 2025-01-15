import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/albums/domain/usecase/albums_usecase.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_event.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_state.dart';
import 'package:gallery_app/my_library.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  // UseCase larni konstruktor yordamida chaqiramiz
  final AlbumsUseCase albumsUseCase;
  final AlbumsItemUseCase albumsItemUseCase;

  AlbumsBloc({
    required this.albumsItemUseCase,
    required this.albumsUseCase,
  }) : super(AlbumsInitial()) {
    on<GetAlbumsEvent>(_getAlbums);
    on<GetAlbumsItemEvent>(_getAlbumsItem);
  }

  // albumlar listni olamiz
  Future<void>? _getAlbums(
      GetAlbumsEvent event, Emitter<AlbumsState> emit) async {
    try {
      emit(AlbumsLoading());

      final result = await albumsUseCase
          .call(NoParams()); // usecasedan kelayotgan ma'lumotni resulga olamiz
      result.fold((failure) {
        emit(AlbumsError(failure
            .message)); // agar malumot error bo'lib kelsa uni emit qilib uiga error ekanligini bildiramiz va hatolikni uiga chiqaramiz
      }, (response) {
        emit(AlbumsSuccess(
            response)); // kelgan ma'lumot success bo'lsa ui ga malumotni yuboramiz response
      });
    } catch (e) {
      emit(AlbumsError(e
          .toString())); // ko'zda tutilmagan hatoliklarni try catch yordamida ushlaymiz va uiga error ni bildiramiz
    }
  }

  // Blocda GetMediaAssetsEvent ni ishlatish
  Future<void> _getAlbumsItem(
      GetAlbumsItemEvent event, Emitter<AlbumsState> emit) async {
    try {
      emit(AlbumsLoading());
      final result = await albumsItemUseCase.call(event
          .selectedAlbum); //AlbumsItemsUseCase dan kelgan ma'lumotni resultga olamiz
      result.fold((failure) {
        emit(AlbumsError(failure
            .message)); // agra resultda error kelsa hatolikni uiga jo'natamiz va hatolik xabarini chiqaramiz
      }, (response) {
        emit(AlbumsItemSuccess(
            response)); // Rasm fayllari muvaffaqiyatli yuklandi
      });
    } catch (e) {
      emit(AlbumsError(e.toString()));// ko'zda tutilmagan hatoliklarni try catch yordamida ushlaymiz va uiga error ni bildiramiz
    }
  }
}
