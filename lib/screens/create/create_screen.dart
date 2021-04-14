import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/screens/create/widgets/cep_field.dart';
import 'package:xlo_mobx/screens/create/widgets/hide_phone_field.dart';
import 'package:xlo_mobx/screens/create/widgets/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextStyle labelStyle = const TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );

  final EdgeInsets contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Novo anúncio'),
      ),
      body: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagesField(createStore),
              Observer(
                builder: (_) {
                  if (createStore.imagesError != null)
                    return Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                      child: Text(
                        createStore.imagesError,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    );
                  else
                    return Container();
                },
              ),
              Observer(
                builder: (_) => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Título *',
                    labelStyle: labelStyle,
                    contentPadding: contentPadding,
                    errorText: createStore.titleError,
                  ),
                  onChanged: createStore.setTitle,
                  enabled: !createStore.loading,
                ),
              ),
              Observer(
                builder: (_) => TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descrição *',
                    labelStyle: labelStyle,
                    contentPadding: contentPadding,
                    errorText: createStore.descriptionError,
                  ),
                  onChanged: createStore.setDescription,
                  enabled: !createStore.loading,
                  maxLines: null,
                ),
              ),
              Observer(
                builder: (_) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Categoria *',
                          style: createStore.category == null
                              ? TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey,
                                  fontSize: 18)
                              : TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey,
                                  fontSize: 14),
                        ),
                        subtitle: createStore.category == null
                            ? null
                            : Text(
                                createStore.category.description,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: createStore.loading
                            ? null
                            : () async {
                                final category = await showDialog(
                                  context: context,
                                  builder: (_) => CategoryScreen(
                                    showAll: false,
                                    selected: createStore.category,
                                  ),
                                );
                                if (category != null) {
                                  createStore.setCategory(category);
                                }
                              },
                      ),
                      if (createStore.categoryError != null)
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: Text(
                            createStore.categoryError,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        )
                      else
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                    ],
                  );
                },
              ),
              CepField(createStore),
              Observer(
                builder: (_) => TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Preço *',
                      labelStyle: labelStyle,
                      contentPadding: contentPadding,
                      prefixText: 'R\$ ',
                      errorText: createStore.priceError),
                  onChanged: createStore.setPriceText,
                  enabled: !createStore.loading,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(centavos: true),
                  ],
                ),
              ),
              HidePhoneField(createStore),
              Observer(
                builder: (_) => GestureDetector(
                  onTap: createStore.invalidSendPressed,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled))
                          return Colors.orange.withAlpha(120);
                        return Colors.orange;
                      }),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                    ),
                    onPressed: createStore.sendAd,
                    child: createStore.loading
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Enviar',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
