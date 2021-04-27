import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/screens/filter/filter_screen.dart';
import 'package:xlo_mobx/screens/home/widgets/bar_button.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class TopBar extends StatelessWidget {
  final homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Observer(
            builder: (_) => BarButton(
              label: homeStore.category?.description ?? 'Categorias',
              onTap: () async {
                final category = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                      showAll: true,
                      selected: homeStore.category,
                    ),
                  ),
                );
                if (category != null) homeStore.setCategory(category);
              },
            ),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.white,
          ),
          BarButton(
            label: 'Filtros',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FilterScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
