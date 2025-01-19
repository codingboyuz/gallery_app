import 'package:dartz/dartz.dart';
import 'package:gallery_app/features/albums/data/datasources/localdata/albums_local_data_source.dart';
import 'package:gallery_app/features/albums/domain/repositories/albums_repository.dart';
import 'package:gallery_app/my_library.dart' show Failure;
import 'package:photo_manager/photo_manager.dart';
import "package:photo_manager/src/types/entity.dart"
    show AssetEntity, AssetPathEntity;


class AlbumsRepositoryImpl implements AlbumsRepository {
//  AlbumsLocalDataSource konstruktor yordamida chaqiramiz
final AlbumsLocalDataSource mediaLocalDataSource;

// konstruktor
AlbumsRepositoryImpl(this.mediaLocalDataSource);

@override
Future<Either<Failure, List<AssetPathEntity>>> loadAlbums() async {
  try {

    final result = await mediaLocalDataSource.loadAlbums();//mediaLocalDataSource chaqiramiz va kelgan ma'lumotni resultga tenglaymiz
    // agar result null bo'lmasa yani bo'sh bo'lsa , biron qiymatga ega bo'lsa shart bajariladi
    if (result.isNotEmpty) {
      // dastur bu qisimga kirsa demak ui kegini etabga malumot success holatda kelganini bildirish uchun
      // Rigth(result) qilib qaytaramiz
      return Right(result);
    } else {
      // Aksholda ma'lumot  error bo'lsa yoki hechqanday ma'lumot bo'lmasa
      // Left() deb error holatni bildiramiz
      return Left(Failure(message: "Image Null"));
    }
  } catch (e) {
    return Left(Failure(message: e.toString())); // ko'zda tutilmagan hatoliklar uchun
  }
}

// bu finkskiyadaham yuqoridagi funksiya kabi bo'lmoqda
@override
Future<Either<Failure, List<AssetEntity>>> loadAlbumsItem(AssetPathEntity entity) async{
  try {
    final result = await mediaLocalDataSource.loadAlbumsItem(entity);
    if (result.isNotEmpty) {
      return Right(result);
    } else {
      return Left(Failure(message: "Album Null"));
    }
  } catch (e) {
    return Left(Failure(message: e.toString()));
  }
}
}
