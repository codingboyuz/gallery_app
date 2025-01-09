import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/my_library.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetMediaPicker getMediaPicker;

  GalleryBloc({required this.getMediaPicker}) : super(GalleryInitial()) {
    on<GetMediaAlbumsEvent>(get);
  }

  Future<void> get() async {}
}
