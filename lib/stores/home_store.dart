import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    autorun((_) async {
      setLoading(true);
      final newAds = await AdRepository().getHomeAdList(
        filter: filter,
        search: search,
        category: category,
      );
      print(newAds);
      adList.addAll(newAds);
      setLoading(false);
    });
  }

  ObservableList<Ad> adList = ObservableList();

  @observable
  String search = '';

  @action
  void setSearch(String value) => search = value;

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @observable
  FilterStore filter = FilterStore();

  @action
  void setFilter(FilterStore value) => filter = value;

  FilterStore get clonedFilter => filter.clone();

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;
}
