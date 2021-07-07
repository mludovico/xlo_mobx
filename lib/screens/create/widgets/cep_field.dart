import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/error_box.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  CepField(this.createStore) : cepStore = createStore.cepStore;

  final CreateStore createStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(
          builder: (_) => TextFormField(
            initialValue: createStore.cepStore.cep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            decoration: InputDecoration(
              labelText: 'CEP *',
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w800,
              ),
              errorText: createStore.addressError,
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            ),
            onChanged: cepStore.setCep,
            enabled: !createStore.loading,
          ),
        ),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading)
              return Container();
            else if (cepStore.address == null && cepStore.error == null)
              return LinearProgressIndicator(
                backgroundColor: Colors.transparent,
              );
            else if (cepStore.error != null)
              return ErrorBox(
                message: cepStore.error,
              );
            else {
              final address = cepStore.address;
              return Container(
                alignment: Alignment.center,
                color: Colors.purple.withAlpha(150),
                height: 50,
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Localização: ${address.district}, ${address.city.name} - ${address.uf.initials}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
