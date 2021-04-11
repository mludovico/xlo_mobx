import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Minha Conta'),
      ),
      body: Container(),
    );
  }
}
