import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/screens/favorites/widgets/favorite_tile.dart';
import 'package:xlo_mobx/stores/favorites_store.dart';

class FavoritesScreen extends StatelessWidget {
  final bool hideDrawer;
  final favoriteStore = GetIt.I<FavoritesStore>();

  FavoritesScreen({this.hideDrawer = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hideDrawer ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Observer(
        builder: (_) {
          if (favoriteStore.favoritesList.isEmpty) {
            return EmptyCard(text: 'Nenhum anúncio favorito');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(2),
            itemCount: favoriteStore.favoritesList.length,
            itemBuilder: (_, index) => FavoriteTile(
              ad: favoriteStore.favoritesList.elementAt(index),
            ),
          );
        },
      ),
    );
  }
}
