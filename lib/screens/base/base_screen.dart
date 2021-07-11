import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/chat/chat_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';
import 'package:xlo_mobx/screens/offline/offline_screen.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController(initialPage: 0);
  final connectivityStore = GetIt.I<ConnectivityStore>();
  ReactionDisposer pageSetterDisposer, connectivityCheckerDisposer;

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();
    pageSetterDisposer = reaction(
      (_) => pageStore.page,
      (page) => pageController.jumpToPage(page),
    );
    connectivityCheckerDisposer = autorun((_) async {
      print('hasConnection: ${connectivityStore.hasConnection}');
      await Future.delayed(Duration(milliseconds: 300));
      if (!connectivityStore.hasConnection) {
        showDialog(
          context: context,
          builder: (_) => OfflineScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          ChatScreen(),
          FavoritesScreen(),
          AccountScreen(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageSetterDisposer();
    connectivityCheckerDisposer();
    super.dispose();
  }
}
