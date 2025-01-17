# Gallery Project TDD Clean Code Architecture

**TDD (Test-Driven Development)** — bu **Testga asoslangan dasturlash** metodologiyasidir, unda dasturchilar kod yozishni boshlashdan oldin testlarni yaratadilar. Bu metodologiya kodning sifatini oshirish, xatoliklarni erta aniqlash va kodni soddalashtirishga yordam beradi.

### TDD vujudga kelishi:
TDD dastlab **xunit** deb atalgan test framework-lari yordamida 1990-yillarda **Kent Beck** tomonidan ishlab chiqilgan. Kent Beck, shuningdek, **Extreme Programming (XP)** metodologiyasining asoschilaridan biri hisoblanadi. TDD metodologiyasi XP ning asosiy prinsiplaridan biri sifatida paydo bo‘ldi.

### TDD jarayoni:
1. **Test yozish**: Kodni yozishdan avval, bajarilishi kerak bo'lgan funksiyalarni sinovdan o‘tkazadigan testlar yoziladi.
2. **Kod yozish**: Testdan muvaffaqiyatli o‘tishi uchun kerakli kod yoziladi.
3. **Testni bajarish**: Yozilgan kod testni muvaffaqiyatli o'tkazishi kerak.
4. **Refaktoring**: Kodingizni tozalash va optimallashtirish uchun refaktoring qilinadi, lekin testlar har doim o'tkaziladi.

TDD dasturchilarga yuqori sifatli, o‘qilishi oson va xatoliklardan xoli kod yozish imkoniyatini beradi.
  TDD yana bir ustunligi ko'dlarni pattrinlarga bo'linishi bu ko'dni o'shni osonlashtiradi va sizdan kegingi dasturchi yoki jamoa bilan ishlagada hechqanday qiyinchliklarsiz loyhani davom etiradi

#Loyha strukturasi (papkalar joylashuvi)
[]()
[.dart_tool](.dart_tool)
[.idea](.idea)
[android](android)
[build](build)
[ios](ios)
[lib](lib)
[core](lib%2Fcore)
[errors](lib%2Fcore%2Ferrors)
[model](lib%2Fcore%2Fmodel)
[routes](lib%2Fcore%2Froutes)
[services](lib%2Fcore%2Fservices)
[theme](lib%2Fcore%2Ftheme)
[usecase](lib%2Fcore%2Fusecase)
[utils](lib%2Fcore%2Futils)
[widget](lib%2Fcore%2Fwidget)
[no_param.dart](lib%2Fcore%2Fno_param.dart)
[features](lib%2Ffeatures)
[albums](lib%2Ffeatures%2Falbums)
[data](lib%2Ffeatures%2Falbums%2Fdata)
[datasources](lib%2Ffeatures%2Falbums%2Fdata%2Fdatasources)
[repositories](lib%2Ffeatures%2Falbums%2Fdata%2Frepositories)
[domain](lib%2Ffeatures%2Falbums%2Fdomain)
[repositories](lib%2Ffeatures%2Falbums%2Fdomain%2Frepositories)
[usecase](lib%2Ffeatures%2Falbums%2Fdomain%2Fusecase)
[presentation](lib%2Ffeatures%2Falbums%2Fpresentation)
[bloc](lib%2Ffeatures%2Falbums%2Fpresentation%2Fbloc)
[ui](lib%2Ffeatures%2Falbums%2Fpresentation%2Fui)
[widget](lib%2Ffeatures%2Falbums%2Fpresentation%2Fwidget)
[gallery](lib%2Ffeatures%2Fgallery)
[main](lib%2Ffeatures%2Fmain)
[injection.dart](lib%2Finjection.dart)
[main.dart](lib%2Fmain.dart)
[my_library.dart](lib%2Fmy_library.dart)
[linux](linux)
[macos](macos)
[test](test)
[web](web)
[windows](windows)
[.flutter-plugins](.flutter-plugins)
[.flutter-plugins-dependencies](.flutter-plugins-dependencies)
[.gitignore](.gitignore)
[.metadata](.metadata)
[analysis_options.yaml](analysis_options.yaml)
[devtools_options.yaml](devtools_options.yaml)
[gallery_app.iml](gallery_app.iml)
[pubspec.lock](pubspec.lock)
[pubspec.yaml](pubspec.yaml)
[README.md](README.md)
