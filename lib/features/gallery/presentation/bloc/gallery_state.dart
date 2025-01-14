abstract class GalleryState<T> {}

class GalleryInitial extends GalleryState {}

class GalleryLoading<T> extends GalleryState {}

class GallerySuccess<T> extends GalleryState {
  final T data;

  GallerySuccess(this.data);
}


class GalleryError<T> extends GalleryState {
  final String error;

  GalleryError(this.error);
}
