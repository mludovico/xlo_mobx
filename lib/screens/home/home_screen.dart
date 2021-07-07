import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/home/widgets/ad_tile.dart';
import 'package:xlo_mobx/screens/home/widgets/create_ad_button.dart';
import 'package:xlo_mobx/screens/home/widgets/info_message.dart';
import 'package:xlo_mobx/screens/home/widgets/search_dialog.dart';
import 'package:xlo_mobx/screens/home/widgets/top_bar.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  final ScrollController scrollController = ScrollController();

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
          Expanded(
            child: Stack(
              children: [
                Observer(
                  builder: (_) {
                    if (homeStore.error != null) {
                      return InfoMessage(
                        icon: Icons.error,
                        text: 'Ocorreu um erro',
                      );
                    }
                    if (homeStore.showProgress) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    }
                    if (homeStore.adList.isEmpty) {
                      return InfoMessage(
                        icon: Icons.thumb_down_outlined,
                        text: 'Hummmm....nenhum anúncio encontrado!',
                      );
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: homeStore.itemCount,
                      itemBuilder: (context, index) {
                        if (index < homeStore.adList.length)
                          return AdTile(
                            ad: homeStore.adList[index],
                          );
                        homeStore.loadNextPage();
                        return Container(
                          height: 10,
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purple),
                            backgroundColor: Colors.grey,
                          ),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: CreateAdButton(scrollController),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
