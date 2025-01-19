# Gallery Project TDD Clean Code Architecture

**TDD (Test-Driven Development)** — bu **Testga asoslangan dasturlash** metodologiyasidir, unda
dasturchilar kod yozishni boshlashdan oldin testlarni yaratadilar. Bu metodologiya kodning sifatini
oshirish, xatoliklarni erta aniqlash va kodni soddalashtirishga yordam beradi.

### TDD vujudga kelishi:

TDD dastlab **xunit** deb atalgan test framework-lari yordamida 1990-yillarda **Kent Beck**
tomonidan ishlab chiqilgan. Kent Beck, shuningdek, **Extreme Programming (XP)** metodologiyasining
asoschilaridan biri hisoblanadi. TDD metodologiyasi XP ning asosiy prinsiplaridan biri sifatida
paydo bo‘ldi.

### TDD jarayoni:

1. **Test yozish**: Kodni yozishdan avval, bajarilishi kerak bo'lgan funksiyalarni sinovdan
   o‘tkazadigan testlar yoziladi.
2. **Kod yozish**: Testdan muvaffaqiyatli o‘tishi uchun kerakli kod yoziladi.
3. **Testni bajarish**: Yozilgan kod testni muvaffaqiyatli o'tkazishi kerak.
4. **Refaktoring**: Kodingizni tozalash va optimallashtirish uchun refaktoring qilinadi, lekin
   testlar har doim o'tkaziladi.

TDD dasturchilarga yuqori sifatli, o‘qilishi oson va xatoliklardan xoli kod yozish imkoniyatini
beradi.
TDD yana bir ustunligi ko'dlarni pattrinlarga bo'linishi bu ko'dni o'shni osonlashtiradi va sizdan
kegingi dasturchi yoki jamoa bilan ishlagada hechqanday qiyinchliklarsiz loyhani davom etiradi

### Loyha strukturasi (papkalar joylashuvi):
<br>

![foldr](assets/readme/structure.webp)
<br>

Struktura shu ko'rinishda bo'ladi hohishga ko'ra boshaqa papkalar ochish
ham mumkin muhumi ko'd strukturasi buzulmasligi lozim;

### TDD Malumot oqimi:
<br>

<div align="center" style="background-color: #ffffff; padding: 10px; display: inline-block;">
  <img src="assets/readme/tdd.webp" alt="tdd" />
</div>

<br>

Yuqaridagi rasmda ko'rishingiz mumkin  arxitekturada 3 ta qatlam mavjud: 
`**Data**`,`**Domain**` va `**Presentation**`. Har birining o'z maqsadi bor va faqat yuqoridagi oqimga
ko'ra o'zaro
aloqada bo'lishlari mumkin;
`**Data**` va `**Presentation**` faqat Domain yordamida bir-biri bilan aloqa qilishi mumkin


# Keling endi men o'z loyhamni tushun tirib o'taman
**Bu loiyhada**-api bilan ishlanmagani uchun bizga `**Remote Data Sources**` mavjud emas bizga  `**Local Data Sources**` o'zi yetarli bo'ladi
Yuqoridagi kodlaringizni qisqacha tahlil qilib, nima ish bajarayotgani va nima uchun **abstract class** bilan ishlayotganingizni tushuntirib beraman.
bizda **`Local Data Sources`** bilan ishlash uchun ushbu `abstract class` mavjud 👇🏻

**`AlbumsLocalDataSource` nima qiladi?**
- Albomlar va albom ichidagi fayllarni boshqaradi.
- Foydalanuvchi ruxsatlarini tekshiradi va media fayllarga kirishni ta'minlaydi.

---
```dart
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
```
Endi bu class dan meros olamiz

```dart
// Asosiy implementatsiya class, bu yerda lokal media ma'lumotlarini olish logikasi yozilgan.
class AlbumsLocalDataSourceImpl implements AlbumsLocalDataSource {
  /// Qurilmadagi mavjud albomlarni yuklaydi.
  /// Agar foydalanuvchi media fayllarga ruxsat bergan bo'lsa, albomlar ro'yxatini qaytaradi.
  /// Aks holda, foydalanuvchini sozlamalar sahifasiga yo'naltiradi.
  @override
  Future<List<AssetPathEntity>> loadAlbums() async {
     // Media fayilariga kirish uchin ruxsat so'raymiz.
    var permission = await PhotoManager.requestPermissionExtend();

    // Albomlar ro'yxatini saqlash uchun bo'sh ro'yxat yaratamiz.
    List<AssetPathEntity> albumList = [];

    if (permission.isAuth) {
      // Agar ruxsat berilgan bo'lsa, albomlarni yuklaymiz.
      albumList = await PhotoManager.getAssetPathList(
        type: RequestType.common, // Rasmlar va videolarni yuklaydi.
      );
    } else {
      // Agar ruxsat berilmagan bo'lsa, foydalanuvchini sozlamalar oynasiga "Permission setting" o'tkazamiz.
      PhotoManager.openSetting();
    }

    // Albomlar ro'yxatini qaytaramiz.
    return albumList;
  }

  /// Berilgan albomning ichidagi media fayllarni yuklaydi.
  /// [selectedAlbum] - bu albom linki yani albom joylashgan joyi.
  /// Albom ichidagi barcha fayllarni qaytaradi.
  @override
  Future<List<AssetEntity>> loadAlbumsItem(
      AssetPathEntity selectedAlbum) async {
    // Albom ichidagi media fayllar sonini aniqlaymiz.
    int assetCount = await selectedAlbum.assetCountAsync;

    // Media fayllarni yuklaymiz (0-dan boshlab to'liq ro'yxatni).
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0, // Boshlanish indeksi.
      end: assetCount, // Albomdagi fayllar soni.
    );

    // Media fayllar ro'yxatini qaytaramiz.
    return assetList;
  }
}
```
---

### 2. **Abstract Class (Interfeys) Nega Kerak?**
Abstract class yozishdan maqsad:
1. **Modullarni ajratish va yanada aniq struktura yaratish:**
   - `AlbumsLocalDataSource` — bu interfeys bo'lib, **faqatgina funksiyalarni e'lon qiladi**. Bu esa implementatsiyani (asosiy kodni) boshqacha yozishga imkon beradi.
   - Sizning implementatsiyangiz (`AlbumsLocalDataSourceImpl`) esa interfeysdagi funksiyalarni haqiqiy hayotda qanday ishlashini ko'rsatadi.

2. **Moslashuvchanlik (Flexibility):**
   - Agar boshqa turdagi media manager kutubxonasiga (masalan, boshqa kutubxona yoki backend) o'tmoqchi bo'lsangiz, faqat yangi implementatsiya yozasiz.
   - Interfeys orqali boshqa qismdagi kodga ta'sir qilmasdan, yangi implementatsiya ishlatiladi.

3. **Kodni o'qilishi va testlanishini osonlashtirish:**
   - Abstract class bilan ishlaganda, ilova logikasi toza va tushunarli bo'ladi. Har bir sinf o'z vazifasini bajaradi va bir joyga haddan tashqari ko'p kod yozilmaydi.

4. **Jamoaviy ishlashda yordam:**
   - Jamoangizdagi boshqa dasturchilar sizning abstract classingizdan foydalanib, uning ustiga boshqa implementatsiyalar yozishi yoki turli modullarga ulanishi mumkin.

---

#### **Implementatsiya: `AlbumsLocalDataSourceImpl`**
Bu sinf yuqoridagi interfeysning funksiyalarini **haqiqiy hayotda bajaradigan kodni** o'z ichiga oladi:

1. **`loadAlbums()`**:
   - Media fayllarga ruxsat so'raydi (`PhotoManager.requestPermissionExtend`).
   - Ruxsat berilgan taqdirda qurilmadagi barcha albomlarni qaytaradi (`PhotoManager.getAssetPathList` yordamida).
   - Agar foydalanuvchi ruxsat bermasa, `PhotoManager.openSetting` orqali ruxsat olish oynasini ochadi.

2. **`loadAlbumsItem(AssetPathEntity selectedAlbum)`**:
   - Berilgan albomning ichidagi barcha fayllarni yuklaydi (`selectedAlbum.getAssetListRange` yordamida).
   - Bu funksiya faqatgina tanlangan albom ichidagi fayllarni olib keladi.







