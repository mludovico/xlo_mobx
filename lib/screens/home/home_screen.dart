import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/home/widgets/search_dialog.dart';
import 'package:xlo_mobx/screens/home/widgets/top_bar.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (_) => SearchDialog(
        currentSearch: homeStore.search,
      ),
    );
    if (search != null) homeStore.setSearch(search);
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Observer(builder: (_) {
          if (homeStore.search.isEmpty) {
            return Text('XLO');
          } else {
            return GestureDetector(
              child: LayoutBuilder(builder: (_, constraints) {
                return Text(
                  homeStore.search,
                );
              }),
              onTap: () => openSearch(context),
            );
          }
        }),
        actions: [
          Observer(builder: (_) {
            if (homeStore.search.isEmpty) {
              return IconButton(
                onPressed: () {
                  openSearch(context);
                },
                icon: Icon(
                  Icons.search,
                ),
              );
            } else {
              return IconButton(
                onPressed: () {
                  homeStore.setSearch('');
                },
                icon: Icon(
                  Icons.clear,
                ),
              );
            }
          }),
        ],
      ),
      body: Column(
        children: [
          TopBar(),
        ],
      ),
    );
  }
}
