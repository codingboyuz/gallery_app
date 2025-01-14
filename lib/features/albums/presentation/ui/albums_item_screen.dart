import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/services/service.dart';
import 'package:gallery_app/core/widget/media_items.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_bloc.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_event.dart';
import 'package:gallery_app/features/albums/presentation/bloc/albums_state.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumsItemScreen extends StatefulWidget {
  final AssetPathEntity selectedAlbum;

  const AlbumsItemScreen({super.key, required this.selectedAlbum});

  @override
  _AlbumsItemScreenState createState() => _AlbumsItemScreenState();
}

class _AlbumsItemScreenState extends State<AlbumsItemScreen> {
  @override
  void initState() {
    super.initState();
    _loadAlbumItems();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    context.read<AlbumsBloc>().add(GetAlbumsEvent());
    super.deactivate();
  }

  void _loadAlbumItems() {
    context.read<AlbumsBloc>().add(GetAlbumsItemEvent(widget.selectedAlbum));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<AlbumsBloc, AlbumsState>(
        bloc: context.read<AlbumsBloc>(),
        builder: (context, state) {
          if (state is AlbumsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AlbumsItemSuccess) {
            final data = AppServices.groupImagesByDate(state.data);
            return MediaItems(
              ungroupedImages: state.data,
              data: data,
            );
          }
          if (state is AlbumsError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return Container();
        },
      ),
    );
  }
}
