import 'package:flutter/material.dart';
import 'package:xlo_mobx/services/init_parse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initParse();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Container(),
    );
  }
}