import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/session_store.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Minha Conta'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: GetIt.I<SessionStore>().logout,
          )
        ],
      ),
      body: Container(

      ),
    );
  }
}
