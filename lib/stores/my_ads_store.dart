import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/session_store.dart';

part 'my_ads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    _getMyAds();
  }

  @observable
  List<Ad> allAds = [];

  @computed
  List<Ad> get activeAds =>
      allAds.where((ad) => ad.status == AdStatus.ACTIVE).toList();
  List<Ad> get pendingAds =>
      allAds.where((ad) => ad.status == AdStatus.PENDING).toList();
  List<Ad> get soldAds =>
      allAds.where((ad) => ad.status == AdStatus.SOLD).toList();

  Future<void> _getMyAds() async {
    setLoading(true);
    final user = GetIt.I<SessionStore>().user;
    try {
      allAds = await AdRepository().getMyAds(user);
    } on Exception catch (e) {
      // TODO
    } finally {
      setLoading(false);
    }
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  void refresh() => _getMyAds();

  Future<void> sellAd(Ad ad) async {
    setLoading(true);
    await AdRepository().sell(ad);
    await _getMyAds();
    setLoading(false);
  }

  Future<void> deleteAd(Ad ad) async {
    setLoading(true);
    await AdRepository().delete(ad);
    await _getMyAds();
    setLoading(false);
  }
}
