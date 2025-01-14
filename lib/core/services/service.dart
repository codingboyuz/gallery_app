import 'package:photo_manager/photo_manager.dart';
import 'package:intl/intl.dart';

abstract class AppServices {
  static Map<String, List<AssetEntity>> groupImagesByDate(
      List<AssetEntity> images) {
    Map<String, List<AssetEntity>> groupedImages = {};

    for (var image in images) {
      // Sana faqat yili, oyi va kuni
      String date = image.createDateTime.toLocal().toString().split(' ')[0];
      if (groupedImages[date] == null) {
        groupedImages[date] = [];
      }
      groupedImages[date]!.add(image);
    }

    return groupedImages;
  }

  static String dateFormat(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Unknown Date'; // Default qiymat
    }

    try {
      // Stringni DateTime obyektiga o'zgartirish
      DateTime date = DateTime.parse(dateString);

      // Sana formatlash
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      // Agar format noto'g'ri bo'lsa
      return 'Invalid Date';
    }
  }
}


