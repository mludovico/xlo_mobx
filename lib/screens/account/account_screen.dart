import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/my_ads/my_ads_screen.dart';
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
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            GetIt.I<SessionStore>().user.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.purple,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            GetIt.I<SessionStore>().user.mail,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.purple),
                        ),
                        child: Text(
                          'EDITAR',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Meus Anúncios',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyAdsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Favoritos',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
