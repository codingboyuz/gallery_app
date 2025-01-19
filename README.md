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

Yuqaridagi rasmda ko'rishingiz mumkin arxitekturada 3 ta qatlam mavjud:
`**Data**`,`**Domain**` va `**Presentation**`. Har birining o'z maqsadi bor va faqat yuqoridagi
oqimga
ko'ra o'zaro
aloqada bo'lishlari mumkin;
`**Data**` va `**Presentation**` faqat Domain yordamida bir-biri bilan aloqa qilishi mumkin

# Keling endi men o'z loyhamni tushun tirib o'taman

**Bu loiyhada**-api bilan ishlanmagani uchun bizga `**Remote Data Sources**` mavjud emas
bizga  `**Local Data Sources**`ni o'zi yetarli bo'ladi.
bizda **`Local Data Sources`** bilan ishlash uchun ushbu `abstract class AlbumsLocalDataSource`
mavjud 👇🏻

### **`AlbumsLocalDataSource` nima qiladi?**

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

### **Abstract Class (Interfeys) Nega Kerak?**

Abstract class yozishdan maqsad:

1. **Modullarni ajratish va yanada aniq struktura yaratish:**
    - `AlbumsLocalDataSource` — bu interfeys bo'lib, **faqatgina funksiyalarni e'lon qiladi**. Bu
      esa implementatsiyani (asosiy kodni) boshqacha yozishga imkon beradi.
    - Sizning implementatsiyangiz (`AlbumsLocalDataSourceImpl`) esa interfeysdagi funksiyalarni
      haqiqiy hayotda qanday ishlashini ko'rsatadi.

2. **Moslashuvchanlik (Flexibility):**
    - Agar boshqa turdagi media manager kutubxonasiga (masalan, boshqa kutubxona yoki backend)
      o'tmoqchi bo'lsangiz, faqat yangi implementatsiya yozasiz.
    - Interfeys orqali boshqa qismdagi kodga ta'sir qilmasdan, yangi implementatsiya ishlatiladi.

3. **Kodni o'qilishi va testlanishini osonlashtirish:**
    - Abstract class bilan ishlaganda, ilova logikasi toza va tushunarli bo'ladi. Har bir sinf o'z
      vazifasini bajaradi va bir joyga haddan tashqari ko'p kod yozilmaydi.

4. **Jamoaviy ishlashda yordam:**
    - Jamoangizdagi boshqa dasturchilar sizning abstract classingizdan foydalanib, uning ustiga
      boshqa implementatsiyalar yozishi yoki turli modullarga ulanishi mumkin.

---
Endi bu `abstract class AlbumsLocalDataSource` dan meros olamiz

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
     Future<List<AssetEntity>> loadAlbumsItem(AssetPathEntity selectedAlbum) async {
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

#### **Implementatsiya: `AlbumsLocalDataSourceImpl`**

1. **`loadAlbums()`**:
    - Media fayllarga ruxsat so'raydi (`PhotoManager.requestPermissionExtend`).
    - Ruxsat berilgan taqdirda qurilmadagi barcha albomlarni
      qaytaradi (`PhotoManager.getAssetPathList` yordamida).
    - Agar foydalanuvchi ruxsat bermasa, `PhotoManager.openSetting` orqali ruxsat olish oynasini
      ochadi.

2. **`loadAlbumsItem(AssetPathEntity selectedAlbum)`**:
    - Berilgan albomning ichidagi barcha fayllarni yuklaydi (`selectedAlbum.getAssetListRange`
      yordamida).
    - Bu funksiya faqatgina tanlangan albom ichidagi fayllarni olib keladi.

---
# Repository haqida

### Repository: Nima uchun kerak?

**Repository** - bu dastur arxitekturasida **ma'lumotlar qatlamini boshqaruvchi
va ma'lumot manbalari (masalan, lokal ma'lumotlar bazasi yoki API) bilan
UI o'rtasida ko'prik bo'lib ishlovchi qatlamdir**. Repository, ma'lumotlar
manbalarini abstraksiyalash orqali kodni modulli va oson boshqariladigan qiladi.

---

1. **Kodning o'qiluvchanligini oshirish:**
    - Ma'lumotlar olish logikasi bir joyda markazlashtiriladi.
    - UI qatlami faqat repository orqali ishlaydi, bu esa kodni osonroq boshqarishga imkon beradi.

2. **Testlashni osonlashtirish:**
    - Repository orqali ma'lumotlarni osonlikcha sinab ko'rish va ularni soxta manbalar bilan
      almashtirish mumkin.
    - Bu **Unit Test** va **Integration Test**larni bajarishni yengillashtiradi.

---

### Repository Loyihada Qanday Ishlaydi?

1. **Abstraktsiya yaratish:**
- `AlbumsRepository` interfeysini yaratamiz. U qanday funksiyalar kerakligini belgilaydi,
  masalan:
<br>

  ```dart
  abstract interface class AlbumsRepository {
    Future<Either<Failure, List<AssetPathEntity>>> loadAlbums();
    Future<Either<Failure, List<AssetEntity>>> loadAlbumsItem(AssetPathEntity entity);
  }
  ```
  
<br>
  
  - Bu UI qatlamiga faqat ma'lumot olish uchun qanday interfeyslar mavjudligini bildiradi.

2. **Implementatsiya:**
    - `AlbumsRepositoryImpl` orqali bu interfeysni amalga oshirasiz. Bu joyda lokal va tarmoq
      manbalaridan ma'lumot olish logikasi yoziladi:
<br>
   
   ```dart
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
   ```
<br>

---

# Use Cases haqida

 ## ✅ **Use Case haqida tushuncha va vazifasi**

 **Use Case (Ish holati)** bu **Clean Architecture**'da asosiy qatlamlardan biri bo'lib,
  biznes mantiqni (business logic) ajratib olish uchun ishlatiladi.
  Use Case **domain layer**da joylashadi va u **foydalanuvchi ilovadan qanday foydalanishini ifodalaydi**.

 ### 🎯 **Use Case vazifasi**:
 - Ma'lumot olish yoki o'zgartirish jarayonidagi **biznes qoidalarni bajaradi**.
 - **Repository**dan ma'lumotni oladi va uni kerakli formatda qaytaradi.
 - **UI yoki boshqa qatlamlar** bilan ishlashda to'g'ridan-to'g'ri Repository'ga murojaat qilishning oldini oladi,
  shunda kod **modullashtirilgan** va **o'qilishi oson** bo'ladi.

 --

 ### ✅ **Use Case qanday ishlaydi?**

 1. **UI yoki ViewModel** **Use Case**'ni chaqiradi.
 2. **Use Case** esa **Repository** bilan bog'lanib, ma'lumotni oladi.
 3. Agar ma'lumot muvaffaqiyatli yuklansa, **Right (success)** qiymat qaytaradi.
 4. Agar xato bo'lsa, **Left (failure)** qiymat qaytaradi.

 ---

 ### ✅ **Use Case ning afzalliklari:**

 1. **Biznes mantiqni ajratadi**: UI yoki boshqa qatlamlar faqat Use Case'lar bilan ishlaydi, bu esa **tartib va modullashtirishni** yaxshilaydi.
 2. **Test qilishni osonlashtiradi**: Har bir Use Case alohida test qilinadi.
 3. **Kodni qayta foydalanish imkonini beradi**: Bir xil biznes qoidalarni turli joylarda ishlatishingiz mumkin.

 ---


 ### ✅ **Xulosa:**

 | **Termin**            | **Izoh**                                          |
 |-----------------------|---------------------------------------------------|
 | **Use Case**           | Biznes mantiqni bajaruvchi sinf.                 |
 | **call() metodi**      | Use Case'dan foydalanish uchun asosiy metod.     |
 | **Repository**         | Ma'lumot manbasi bilan ishlovchi qatlam.         |
 | **Either**             | Muvaffaqiyat yoki xatolikni saqlovchi struktura. |

 ❓ **Savol tug'ilsa, bemalol so'rashingiz mumkin!** 😃
