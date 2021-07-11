import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';
import 'package:xlo_mobx/stores/session_store.dart';

class EditAccountScreen extends StatelessWidget {
  final store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Observer(
                            builder: (_) => GestureDetector(
                              child: Container(
                                color: store.userType.index == 0
                                    ? Colors.purple
                                    : Colors.grey,
                                alignment: Alignment.center,
                                child: Text(
                                  'Particular',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: store.loading
                                  ? null
                                  : () {
                                      store.setUserType(0);
                                    },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Observer(
                            builder: (_) => GestureDetector(
                              child: Container(
                                color: store.userType.index == 1
                                    ? Colors.purple
                                    : Colors.grey,
                                alignment: Alignment.center,
                                child: Text(
                                  'Profissional',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: store.loading
                                  ? null
                                  : () {
                                      store.setUserType(1);
                                    },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nome*',
                        errorText: store.nameError,
                      ),
                      initialValue: store.name,
                      onChanged: store.setName,
                      enabled: !store.loading,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Telefone*',
                        errorText: store.phoneError,
                      ),
                      initialValue: store.phone,
                      onChanged: store.setPhone,
                      enabled: !store.loading,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova senha*',
                        errorText: store.passwordError,
                      ),
                      obscureText: true,
                      onChanged: store.setPassword,
                      enabled: !store.loading,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Confirme a nova senha*',
                        errorText: store.passwordConfirmationError,
                      ),
                      obscureText: true,
                      onChanged: store.setPasswordConfirmation,
                      enabled: !store.loading,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Observer(
                    builder: (_) => store.generalError == null
                        ? Container()
                        : Container(
                            color: Colors.red,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              store.generalError,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Observer(
                      builder: (_) => ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              final color = Colors.orange;
                              if (states.contains(MaterialState.disabled))
                                return color.withAlpha(90);
                              return color;
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: store.save,
                        child: store.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.purple),
                                ),
                              )
                            : Text('Salvar'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            final color = Colors.deepOrange;
                            if (states.contains(MaterialState.disabled))
                              return color.withAlpha(90);
                            return color;
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        store.logout();
                      },
                      child: Text('Sair'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
