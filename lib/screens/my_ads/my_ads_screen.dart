import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/screens/my_ads/widgets/active_tile.dart';
import 'package:xlo_mobx/screens/my_ads/widgets/pending_tile.dart';
import 'package:xlo_mobx/screens/my_ads/widgets/sold_tile.dart';
import 'package:xlo_mobx/stores/my_ads_store.dart';

class MyAdsScreen extends StatefulWidget {
  final int initialTab;

  const MyAdsScreen({Key key, this.initialTab = 0}) : super(key: key);

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  MyAdsStore store;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );
    store = MyAdsStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus anúncios'),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.orange,
          tabs: [
            Tab(
              child: Text('ATIVOS'),
            ),
            Tab(
              child: Text('PENDENTES'),
            ),
            Tab(
              child: Text('VENDIDOS'),
            ),
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          if (store.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          return TabBarView(
            controller: tabController,
            children: [
              Observer(builder: (_) {
                print(store.activeAds.length);
                if (store.activeAds.isEmpty)
                  return EmptyCard(
                    text: 'Você ainda não tem nenhum anúncio ativo.',
                  );
                return ListView.builder(
                    itemCount: store.activeAds.length,
                    itemBuilder: (_, index) {
                      return ActiveTile(store.activeAds[index], store);
                    });
              }),
              Observer(builder: (_) {
                print(store.pendingAds.length);
                if (store.pendingAds.isEmpty)
                  return EmptyCard(
                    text: 'Você ainda não tem nenhum anúncio pendente.',
                  );
                return ListView.builder(
                    itemCount: store.pendingAds.length,
                    itemBuilder: (_, index) {
                      return PendingTile(store.pendingAds[index]);
                    });
              }),
              Observer(builder: (_) {
                print(store.soldAds.length);
                if (store.soldAds.isEmpty) {
                  return EmptyCard(
                    text: 'Você ainda não tem nenhum anúncio vendido.',
                  );
                }
                return ListView.builder(
                    itemCount: store.soldAds.length,
                    itemBuilder: (_, index) {
                      return SoldTile(store.soldAds[index], store);
                    });
              }),
            ],
          );
        },
      ),
    );
  }
}
