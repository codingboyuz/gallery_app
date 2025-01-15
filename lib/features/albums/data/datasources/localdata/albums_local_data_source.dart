import 'package:photo_manager/photo_manager.dart';

/*
  Rasim Albumlarni  olish uchun AlbumsLocalDataSource abstract class yozamiz
  va kerak bo'ladigan funksiyalarni yozib olamiz va AlbumsLocalDataSourceImpl class sida implements qilib meros olazim
  bu tarizda meros olish abstract class sidagi barcha funksiyalarni @override qilishga majburlaydi
  shu bilan birga funksiyani tanasini yozishni esdan chiqishini oldini olib qoladi
*/

abstract interface class AlbumsLocalDataSource {
  Future<List<AssetPathEntity>> loadAlbums();
  Future<List<AssetEntity>> loadAlbumsItem(AssetPathEntity selectedAlbum);
}
