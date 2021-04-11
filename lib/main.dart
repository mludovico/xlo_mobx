import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/services/init_parse.dart';
import 'package:xlo_mobx/services/setup_locators.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initParse();
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        backgroundColor: Colors.purple,
        scaffoldBackgroundColor: Colors.purple
      ),
      debugShowCheckedModeBanner: false,
      title: 'XLO',
      home: BaseScreen(),
    );
  }
}