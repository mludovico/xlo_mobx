import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/session_store.dart';

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(SessionStore());
  GetIt.I.registerSingleton(CategoryStore());
  GetIt.I.registerSingleton(HomeStore());
}
