import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class HidePhoneField extends StatelessWidget {
  final CreateStore createStore;

  HidePhoneField(this.createStore);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Observer(
            builder: (_) => Checkbox(
              value: createStore.hidePhone,
              onChanged: createStore.loading ? null : createStore.setHidePhone,
              activeColor: Colors.purple,
            ),
          ),
          Flexible(
            child: Text('Ocultar meu telefone neste anúncio'),
          ),
        ],
      ),
    );
  }
}
