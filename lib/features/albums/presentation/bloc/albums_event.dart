import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

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
