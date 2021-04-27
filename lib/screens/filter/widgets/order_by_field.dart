import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/widgets/chip_button.dart';
import 'package:xlo_mobx/screens/filter/widgets/section_label.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField(this.filterStore);
  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel('Organizar por'),
        Observer(
          builder: (_) => Row(
            children: [
              ChipButton(
                'Data',
                filterStore.orderBy,
                OrderBy.DATE,
                () {
                  filterStore.setOrderBy(OrderBy.DATE);
                },
              ),
              SizedBox(
                width: 8,
              ),
              ChipButton(
                'Preço',
                filterStore.orderBy,
                OrderBy.PRICE,
                () {
                  filterStore.setOrderBy(OrderBy.PRICE);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
