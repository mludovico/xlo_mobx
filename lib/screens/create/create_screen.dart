import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
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
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagesField(createStore),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título *',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição *',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                ),
                maxLines: null,
              ),
              Observer(
                builder: (_) => ListTile(
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
                  onTap: () async {
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
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CEP *',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Preço *',
                    labelStyle: labelStyle,
                    contentPadding: contentPadding,
                    prefixText: 'R\$ '),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
