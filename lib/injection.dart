import 'package:gallery_app/features/gallery/data/datasources/localdata/media_local_data_source.dart';
import 'package:gallery_app/features/gallery/data/datasources/localdata/media_local_data_source_impl.dart';
import 'package:gallery_app/features/gallery/data/repositories/media_repository_impl.dart';
import 'package:gallery_app/features/gallery/domain/repositories/media_repository.dart';
import 'package:gallery_app/features/gallery/domain/usecase/media_picker_usecase.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initDataSource();
  initRepositories();
  initUseCases();
  initBlocs();
}

void initDataSource() {
  getIt.registerLazySingleton<MediaLocalDataSource>(
      () => MediaLocalDataSourceImpl());
}

// void initRepositories() {
//   getIt.registerLazySingleton<MediaRepository>(
//         () => MediaRepositoryImpl(getIt<MediaLocalDataSource>()),
//   );
// }
void initRepositories() {
  // `MediaRepositoryImpl` ni alohida ro'yxatdan o'tkazish
  getIt.registerLazySingleton<MediaRepositoryImpl>(
    () => MediaRepositoryImpl(getIt<MediaLocalDataSource>()),
  );
}

void initUseCases() {
  getIt.registerLazySingleton(
      () => MediaAlbumsUseCase(getIt<MediaRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => MediaAssetsUseCase(getIt<MediaRepositoryImpl>()));
}

void initBlocs() {
  getIt.registerFactory(() => GalleryBloc(
      mediaAssetsUseCase: getIt<MediaAssetsUseCase>(),
      mediaAlbumsUseCase: getIt<MediaAlbumsUseCase>()));
}
