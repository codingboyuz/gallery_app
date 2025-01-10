import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/routes/routes.dart';
import 'package:gallery_app/features/gallery/domain/usecase/media_picker_usecase.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/ui/gallery_screen.dart';
import 'package:gallery_app/injection.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static List<PageEntity> routes() {
    return [
      PageEntity(
          path: AppRoutes.GALLERY,
          page: const GalleryScreen(),
          bloc: BlocProvider(
              create: (_) => GalleryBloc(
                  mediaAlbumsUseCase: getIt<MediaAlbumsUseCase>(),
                  mediaAssetsUseCase: getIt<MediaAssetsUseCase>()))),
    ];
  }

  static List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = <dynamic>[];

    for (var blocer in routes()) {
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }

  static MaterialPageRoute? generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        if (result.first.path == AppRoutes.initialRoute) {
          return MaterialPageRoute<void>(
              builder: (_) => const GalleryScreen(), settings: settings);
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
