import 'package:gallery_app/features/albums/data/datasources/localdata/albums_local_data_source_impl.dart';
import 'package:gallery_app/features/albums/data/repositories/albums_repository_impl.dart';
import 'package:gallery_app/features/albums/domain/usecase/albums_usecase.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_bloc.dart';
import 'package:gallery_app/features/gallery/data/datasources/localdata/media_local_data_source_impl.dart';
import 'package:gallery_app/features/gallery/data/repositories/media_repository_impl.dart';
import 'package:gallery_app/features/gallery/domain/usecase/media_picker_usecase.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/main/bloc/main_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initDataSource();
  initRepositories();
  initUseCases();
  initBlocs();
}

void initDataSource() {
  getIt.registerLazySingleton<MediaLocalDataSourceImpl>(
      () => MediaLocalDataSourceImpl());
  getIt.registerLazySingleton<AlbumsLocalDataSourceImpl>(
      () => AlbumsLocalDataSourceImpl());
}

void initRepositories() {
  // `MediaRepositoryImpl` ni alohida ro'yxatdan o'tkazish
  getIt.registerLazySingleton<MediaRepositoryImpl>(
    () => MediaRepositoryImpl(getIt<MediaLocalDataSourceImpl>()),
  );
  getIt.registerLazySingleton<AlbumsRepositoryImpl>(
    () => AlbumsRepositoryImpl(getIt<AlbumsLocalDataSourceImpl>()),
  );
}

void initUseCases() {
  getIt.registerLazySingleton(
      () => AlbumsUseCase(getIt<AlbumsRepositoryImpl>()));

  getIt.registerLazySingleton(
      () => AlbumsItemUseCase(getIt<AlbumsRepositoryImpl>()));

  getIt.registerLazySingleton(
      () => MediaAssetsUseCase(getIt<MediaRepositoryImpl>()));
}

void initBlocs() {
  getIt.registerFactory(() => GalleryBloc(
        mediaAssetsUseCase: getIt<MediaAssetsUseCase>(),
      ));
  getIt.registerFactory(() => AlbumsBloc(
        albumsItemUseCase: getIt<AlbumsItemUseCase>(),
        albumsUseCase: getIt<AlbumsUseCase>(),
      ));

  getIt.registerFactory(() => MainBloc());
}
