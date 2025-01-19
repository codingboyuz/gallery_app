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










