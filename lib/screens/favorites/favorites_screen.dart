import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Container(),
    );
  }
}
