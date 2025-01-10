import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class GetMediaAlbumsEvent extends GalleryEvent{

}
class GetMediaAssetsEvent extends GalleryEvent {
  final AssetPathEntity selectedAlbum;

  const GetMediaAssetsEvent(this.selectedAlbum);
}