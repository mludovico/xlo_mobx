import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/page_store.dart';

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
}