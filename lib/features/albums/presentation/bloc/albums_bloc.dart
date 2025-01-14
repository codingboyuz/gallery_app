import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/albums/domain/usecase/albums_usecase.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_event.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_state.dart';
import 'package:gallery_app/my_library.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final AlbumsUseCase albumsUseCase;
  final AlbumsItemUseCase albumsItemUseCase;

  AlbumsBloc({
    required this.albumsItemUseCase,
    required this.albumsUseCase,
  }) : super(AlbumsInitial()) {
    on<GetAlbumsEvent>(_getAlbums);
    on<GetAlbumsItemEvent>(_getAlbumsItem);

  }

  Future<void>? _getAlbums(
      GetAlbumsEvent event, Emitter<AlbumsState> emit) async {
    try {
      emit(AlbumsLoading());

      final result = await albumsUseCase.call(NoParams());
      result.fold((failure) {
        emit(AlbumsError(failure.message));
      }, (response) {
        emit(AlbumsSuccess(response));
      });
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }


  // Blocda GetMediaAssetsEvent ni ishlatish
  Future<void> _getAlbumsItem(
      GetAlbumsItemEvent event, Emitter<AlbumsState> emit) async {
    try {
      emit(AlbumsLoading());
      final result = await albumsItemUseCase.call(event.selectedAlbum);
      result.fold((failure) {
        emit(AlbumsError(failure.message));
      }, (response) {
        emit(AlbumsItemSuccess(
            response)); // Rasm fayllari muvaffaqiyatli yuklandi
      });
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }





}
