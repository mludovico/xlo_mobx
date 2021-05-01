import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/widgets/price_field.dart';
import 'package:xlo_mobx/screens/filter/widgets/section_label.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  PriceRangeField(this.filterStore);
  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel('Fixa de preços'),
        Row(
          children: [
            PriceField(
              'Min',
              filterStore.setMinPrice,
              filterStore.minPrice,
            ),
            PriceField(
              'Max',
              filterStore.setMaxPrice,
              filterStore.maxPrice,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: Observer(
            builder: (_) => Text(
              filterStore.priceError ?? '',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
