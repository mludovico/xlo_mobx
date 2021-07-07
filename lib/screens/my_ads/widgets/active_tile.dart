import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/my_ads_menu_choice.dart';
import 'package:xlo_mobx/screens/ad_screen/ad_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/stores/my_ads_store.dart';

class ActiveTile extends StatelessWidget {
  final MyAdsStore store;
  final Ad ad;
  ActiveTile(this.ad, this.store);

  final choices = [
    MenuChoice(
      index: 0,
      title: 'Editar',
      iconData: Icons.edit,
    ),
    MenuChoice(
      index: 1,
      title: 'Já vendi',
      iconData: Icons.thumb_up,
    ),
    MenuChoice(
      index: 2,
      title: 'Excluir',
      iconData: Icons.delete,
    ),
  ];

  Future<void> editAd(BuildContext context) async {
    print(ad.toMap());
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateScreen(ad: ad),
      ),
    );
    if (success != null && success) {
      store.refresh();
    }
  }

  void sellAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Vendido'),
        content: Text('Confirmar a venda de ${ad.title}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'Não',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              store.sellAd(ad);
            },
            child: Text(
              'Sim',
            ),
          ),
        ],
      ),
    );
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir'),
        content: Text('Confirmar a exclusão de ${ad.title}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Não',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteAd(ad);
            },
            child: Text(
              'Sim',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdScreen(ad),
          ),
        );
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ad.images.isEmpty
                    ? Icon(
                        Icons.image,
                        color: Colors.grey[300],
                        size: 127,
                      )
                    : CachedNetworkImage(
                        imageUrl: ad.images.first,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ad.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ad.price.formattedMoney(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      '${ad.views} visitas',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<MenuChoice>(
                onSelected: (choice) {
                  switch (choice.index) {
                    case 0:
                      editAd(context);
                      break;
                    case 1:
                      sellAd(context);
                      break;
                    case 2:
                      deleteAd(context);
                      break;
                  }
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.purple,
                ),
                itemBuilder: (_) => choices
                    .map(
                      (choice) => PopupMenuItem<MenuChoice>(
                        value: choice,
                        child: Row(
                          children: [
                            Icon(
                              choice.iconData,
                              size: 20,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              choice.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
