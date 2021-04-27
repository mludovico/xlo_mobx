import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/filter/widgets/order_by_field.dart';
import 'package:xlo_mobx/screens/filter/widgets/price_range_field.dart';
import 'package:xlo_mobx/screens/filter/widgets/vnedor_type_field.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class FilterScreen extends StatelessWidget {
  final FilterStore filterStore = FilterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  OrderByField(filterStore),
                  PriceRangeField(filterStore),
                  VendorTypeField(filterStore),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
