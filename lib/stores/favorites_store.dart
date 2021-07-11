import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/favorites_repository.dart';
import 'package:xlo_mobx/stores/session_store.dart';

part 'favorites_store.g.dart';

class FavoritesStore = _FavoritesStore with _$FavoritesStore;

abstract class _FavoritesStore with Store {
  _FavoritesStore() {
    reaction(
      (_) => sessionStore.isLoggedIn,
      (_) => _initList(),
    );
  }
  final SessionStore sessionStore = GetIt.I<SessionStore>();

  ObservableSet<Ad> favoritesList = ObservableSet();

  @action
  Future<void> toggleFavorite(Ad ad) async {
    try {
      if (favoritesList.any((element) => element.id == ad.id)) {
        favoritesList.removeWhere((element) => element.id == ad.id);
        await FavoritesRepository().removeFromFavorite(ad, sessionStore.user);
      } else {
        favoritesList.add(ad);
        await FavoritesRepository().addToFavorite(ad, sessionStore.user);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> _initList() async {
    favoritesList.clear();
    try {
      final favorites =
          await FavoritesRepository().getFavoritesList(sessionStore.user);
      favoritesList.addAll(favorites);
    } catch (e) {
      print(e.toString());
    }
  }
}
