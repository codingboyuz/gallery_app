abstract class AlbumsState<T> {}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading<T> extends AlbumsState {}

class AlbumsSuccess<T> extends AlbumsState {
  final T data;

  AlbumsSuccess(this.data);
}

class AlbumsItemSuccess<T> extends AlbumsState {
  final T data;

  AlbumsItemSuccess(this.data);
}

class AlbumsError<T> extends AlbumsState {
  final String error;

  AlbumsError(this.error);
}
