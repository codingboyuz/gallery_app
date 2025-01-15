import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/routes/routes.dart';
import 'package:gallery_app/features/albums/domain/usecase/albums_usecase.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_bloc.dart';
import 'package:gallery_app/features/albums/presentation/ui/album_screen.dart';
import 'package:gallery_app/features/gallery/domain/usecase/media_assets_usecase.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/ui/gallery_screen.dart';
import 'package:gallery_app/features/main/bloc/main_bloc.dart';
import 'package:gallery_app/features/main/ui/main_screen.dart';
import 'package:gallery_app/injection.dart';

class AppPages {
  // RouteObserver → Ilovaning marshrut (route) o‘zgarishlarini kuzatish uchun ishlatiladi.
  // history → Ilova tarixini saqlash uchun sahifalar nomlarini saqlovchi ro‘yxat.
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  // screen ro'yxati
  static List<PageEntity> routes() {
    return [
      PageEntity(
          path: AppRoutes.MAIN,
          page: MainScreen(),
          bloc: BlocProvider(create: (_) => MainBloc())),
      PageEntity(
        path: AppRoutes.GALLERY,
        page: GalleryScreen(),
        bloc: BlocProvider(
            create: (_) =>
                GalleryBloc(mediaAssetsUseCase: getIt<MediaAssetsUseCase>())),
      ),
      PageEntity(
        path: AppRoutes.ALBUMS,
        page: AlbumsScreen(),
        bloc: BlocProvider(
            create: (_) => AlbumsBloc(
                albumsItemUseCase: getIt<AlbumsItemUseCase>(),
                albumsUseCase: getIt<AlbumsUseCase>())),
      ),
    ];
  }


  // Ilovaning barcha Bloclarini olish uchun ishlatiladi.
  // routes() metodidan sahifalar va ularning Bloclarini olib, ularni ro'yxatga (List) qo‘shadi.
  static List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = <dynamic>[];

    for (var blocer in routes()) {
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }

  // Dynamic routing uchun ishlatiladi.
  // RouteSettings dan kelgan name qiymati orqali sahifani topadi va sahifani yuklaydi.
  // Misol:
  // Agar marshrut (settings.name) AppRoutes.MAIN bo'lsa, ilova MainScreen sahifasini ochadi.
  //  Agar marshrut boshqa bo‘lsa, routes() ro‘yxatidan sahifa topiladi va shu sahifa yuklanadi.

  static MaterialPageRoute? generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        if (result.first.path == AppRoutes.initialRoute) {
          return MaterialPageRoute<void>(
              builder: (_) => MainScreen(), settings: settings);
        }
        return MaterialPageRoute<void>(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return null;
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.path,
    required this.page,
    required this.bloc,
  });
}
