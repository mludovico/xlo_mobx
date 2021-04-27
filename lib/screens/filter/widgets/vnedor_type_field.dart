import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/widgets/chip_button.dart';
import 'package:xlo_mobx/screens/filter/widgets/section_label.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  VendorTypeField(this.filterStore);
  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel('Anúncio'),
        Observer(
          builder: (_) => Wrap(
            runSpacing: 4,
            children: [
              ChipButton(
                'Particular',
                filterStore.vendorType,
                VENDOR_TYPE_PARTICULAR & filterStore.vendorType,
                () {
                  if (filterStore.isTypeParticular) {
                    if (filterStore.isTypeProfessional) {
                      filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                    } else {
                      filterStore.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  } else
                    filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                },
              ),
              SizedBox(width: 8),
              ChipButton(
                'Profissional',
                filterStore.vendorType,
                VENDOR_TYPE_PROFESSIONAL & filterStore.vendorType,
                () {
                  if (filterStore.isTypeProfessional) {
                    if (filterStore.isTypeParticular) {
                      filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                    } else {
                      filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  } else
                    filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
