import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class MediaEntityProvider extends StatelessWidget {
  final AssetEntity entity;

  const MediaEntityProvider({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetEntityImageProvider(
        entity,
        isOriginal: false,
        thumbnailSize: ThumbnailSize(200, 200),
      ),
      fit: BoxFit.cover,
    );
  }
}


/*

### Kodlarni clean code tamoyillari, ishlash tezligi va xavfsizlik jihatidan tahlil qilamiz.

---

### 🧩 1️⃣ **Class orqali yozilgan variant:**

```dart
class MediaEntityProvider extends StatelessWidget {
  final AssetEntity entity;

  const MediaEntityProvider({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetEntityImageProvider(
        entity,
        isOriginal: false,
        thumbnailSize: ThumbnailSize(200, 200),
      ),
      fit: BoxFit.cover,
    );
  }
}
```

### 🧩 2️⃣ **Funksiya orqali yozilgan variant:**

```dart
Widget mediaEntityProvider(AssetEntity entity) {
  return Image(
    image: AssetEntityImageProvider(
      entity,
      isOriginal: false,
      thumbnailSize: ThumbnailSize(200, 200),
    ),
    fit: BoxFit.cover,
  );
}
```

---

### ⚡ **Farqlarini tahlil qilamiz:**

| Metrika             | **Class (StatelessWidget)**                                | **Function (Widget qaytaruvchi)**                        |
|---------------------|-----------------------------------------------------------|--------------------------------------------------------|
| **Clean Code**      | ✅ **Tozaroq va professionalroq**                          | ⚠️ Oddiyroq, lekin ko'p joyda uncha qulay emas         |
| **Performance**     | ⚖️ Bir xil ishlaydi                                        | ⚖️ Bir xil ishlaydi                                    |
| **Reusable**        | ✅ Oson qayta foydalaniladi                                | ❌ Funksiya faqat ma'lum joyda foydalanish uchun qulay |
| **State Management**| ✅ GetX, Provider, Bloc bilan integratsiya qilish oson     | ⚠️ Murakkab loyihalarda moslash qiyin                 |
| **Constructor Args**| ✅ Parametrlar bilan ishlash qulay                          | ❌ Parametrlar uzatilishi uncha oson emas              |
| **Hot Reload**      | ✅ Tezroq aniqlanadi va qayta yuklanadi                    | ⚠️ Kamdan-kam hollarda aniq aniqlanmasligi mumkin     |
| **Xavfsizlik**      | ✅ Xatolarni ushlab turadi va kodni himoyalaydi            | ❌ Potensial xatolarni oldindan ko'rsatmaydi           |

---

### 🛠 **Clean Code tomondan qaysi biri to'g'ri?**

✅ **Class (StatelessWidget) shakli clean code tamoyillariga ko'proq mos keladi.**

- **Professional loyihalarda** `Widget`larni **klass shaklida** yozish tavsiya etiladi.
- **Xato qilish ehtimolini kamaytiradi**, ayniqsa murakkab `state` boshqaruvi bilan ishlaganda.
- `StatelessWidget` **Flutter lifecycle** (hayot tsikli) funksiyalaridan to'liq foydalanish imkonini beradi.

---

### ⚙️ **Performance farqi bormi?**

💡 Ikkala usul ham ishlash tezligida **deyarli bir xil**. Ammo klass shaklida yozilgani **kuzatish (tracking)** va **optimallashtirish** uchun qulayroq bo'ladi.

---

### 🔒 **Xavfsizlik jihatidan qaysi biri yaxshi?**

✅ **Class shakli xavfsizroq**, chunki:

1. **Flutter lifecycle** funksiyalari bilan ishlashga imkon beradi (`initState`, `dispose` va boshqalar).
2. Parametrlarni `final` qilib o'rnatish mumkin, bu esa kodni o'zgarmas (immutable) qiladi.
3. **Null safety** xatolaridan himoya qilish osonroq.

---

### 📋 **Xulosa:**
Agar **bir marta ishlatiladigan oddiy widget** kerak bo'lsa, funksiya variantini ishlatish mumkin.
Ammo **professional darajada, qayta foydalanish uchun yoki murakkab UI yaratishda** **`StatelessWidget` yoki `StatefulWidget`** ishlatish **to'g'ri yo'l** hisoblanadi.

---

### ✅ **Tavsiya qilinadigan toza va xavfsiz variant:**

```dart
class MediaEntityProvider extends StatelessWidget {
  final AssetEntity entity;

  const MediaEntityProvider({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetEntityImageProvider(
        entity,
        isOriginal: false,
        thumbnailSize: ThumbnailSize(200, 200),
      ),
      fit: BoxFit.cover,
    );
  }
}
```

*/


Widget mediaEntityProvider(AssetEntity entity){
  return Image(
    image: AssetEntityImageProvider(
      entity,
      isOriginal: false,
      thumbnailSize: ThumbnailSize(200, 200),
    ),
    fit: BoxFit.cover,
  );
}