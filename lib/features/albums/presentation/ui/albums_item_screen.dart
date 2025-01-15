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
  // AlbumsItemScreen oynasi ochilishi bilan chaqirluvchi funksiya
  @override
  void initState() {
    super.initState();
    // AlbumsScreen oynasi ochilganda konstruktordan kelgan album "path" linkini
    // GetAlbumsItemEvent ga beribb yuboradi va shu linkdagi rasimlarni olib keladi

    context.read<AlbumsBloc>().add(GetAlbumsItemEvent(widget.selectedAlbum));
  }

  // AlbumsItemScreen oynasi yopilganda chaqirluvchi funksiya
  @override
  void deactivate() {
    // TODO: implement deactivate
    // ushbu oynadan orqaga qaytganda AlbumsScreen oynasiga qaytishdan oldin albumni get qiladi
    context.read<AlbumsBloc>().add(GetAlbumsEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(widget.selectedAlbum.name,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        actions: [
          Icon(
            Icons.menu_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: BlocBuilder<AlbumsBloc, AlbumsState>(
        bloc: context.read<AlbumsBloc>(),
        builder: (context, state) {
          // loading holati
          if (state is AlbumsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Success holari
          if (state is AlbumsItemSuccess) {
            // bu qisimda albumlarni sanalar bilan guruhlaymiz
            final data = AppServices.groupImagesByDate(state.data);
            // MediaItems  da guruhlangan va guruhlanmagan ma'lumotni yuboramiz buning
            // sababi rasimni to'liq ekranda ko'rilayotganda scroll qilish uchun kerak bizga
            return MediaItems(
              title: "",
              ungroupedImages: state.data,
              data: data,
            );
          }
          // Error holari
          if (state is AlbumsError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return Container();
        },
      ),
    );
  }
}
