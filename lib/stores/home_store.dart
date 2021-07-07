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
      print('Autorun triggered');
      try {
        setLoading(true);
        final newAds = await AdRepository().getHomeAdList(
          filter: filter,
          search: search,
          category: category,
          page: page,
        );
        print(newAds);
        addNewAds(newAds);
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e);
      }
    });
  }

  ObservableList<Ad> adList = ObservableList();

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();

  @action
  void setFilter(FilterStore value) {
    filter = value;
    resetPage();
  }

  FilterStore get clonedFilter => filter.clone();

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @action
  void loadNextPage() {
    page++;
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  void resetPage() {
    print('reset page');
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @observable
  bool lastPage = false;

  @action
  void addNewAds(List<Ad> newAds) {
    print('New ads ${newAds.length}');
    if (newAds.length < 10) {
      lastPage = true;
    }
    adList.addAll(newAds);
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;
}
