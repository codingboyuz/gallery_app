import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetMediaAlbumsEvent extends GalleryEvent {}

class GetMediaAssetsEvent extends GalleryEvent {}


