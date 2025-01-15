import 'package:dartz/dartz.dart';
import 'package:gallery_app/features/albums/data/repositories/albums_repository_impl.dart';
import 'package:gallery_app/my_library.dart'
    show UseCase, Failure, NoParams;
import 'package:photo_manager/photo_manager.dart';




class AlbumsItemUseCase implements UseCase<List<AssetEntity>, AssetPathEntity> {
  final AlbumsRepositoryImpl repositoryImpl; // Repository implementatsiyasini olish

  AlbumsItemUseCase(this.repositoryImpl); // Constructor orqali repository'ni kiritamiz

  @override
  Future<Either<Failure, List<AssetEntity>>> call(AssetPathEntity entity) {
    // Repository orqali tanlangan albomning elementlarini olish
    return repositoryImpl.loadAlbumsItem(entity);
  }
}



class AlbumsUseCase implements UseCase<List<AssetPathEntity>, NoParams> {
  final AlbumsRepositoryImpl repositoryImpl; // Repository implementatsiyasini olish

  AlbumsUseCase(this.repositoryImpl); // Constructor orqali repository'ni kiritamiz

  @override
  Future<Either<Failure, List<AssetPathEntity>>> call(NoParams params) {
    // Repository orqali barcha albomlarni olish
    return repositoryImpl.loadAlbums();
  }
}



/*
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

*/