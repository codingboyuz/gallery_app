import 'package:photo_manager/photo_manager.dart';

/// Rasmlar va albomlarni olish uchun abstrakt class.
/// Bu interfeysni implementatsiya qiluvchi classlar quyidagi funksiyalarni bajarishi kerak:
/// 1. `loadAlbums`: Qurilmadagi mavjud albomlarni yuklash.
/// 2. `loadAlbumsItem`: Berilgan albomning ichidagi media fayllarni yuklash.

abstract interface class AlbumsLocalDataSource {
  /// Qurilmadagi barcha albomlarni yuklaydi.
  /// [Future] qaytaradi, u [List<AssetPathEntity>] ichida albomlar ro'yxatini saqlaydi.
  Future<List<AssetPathEntity>> loadAlbums();
  /// Berilgan albomga tegishli media fayllarni yuklaydi.
  /// [Future] qaytaradi, u [List<AssetEntity>] ichida fayllar ro'yxatini saqlaydi.
  Future<List<AssetEntity>> loadAlbumsItem(AssetPathEntity selectedAlbum);
}
