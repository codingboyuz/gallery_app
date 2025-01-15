import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';



//  event bu foydalanuvchi yoki tizim tomonidan sodir bo'lgan voqea yoki signal
// Masalan Foydalanuvchi ekrandagi buttonni bosadi.
// Ilova ochilganda ma'lumot yuklash boshlanadi.
// Formani yuborish, albomni ochish, yoki boshqa harakatlar.

abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetAlbumsEvent extends AlbumsEvent {}



class GetAlbumsItemEvent extends AlbumsEvent {
  final AssetPathEntity selectedAlbum;

  const GetAlbumsItemEvent(this.selectedAlbum);
}
