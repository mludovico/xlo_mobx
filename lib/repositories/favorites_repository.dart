import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class FavoritesRepository {
  Future<void> addToFavorite(Ad ad, User user) async {
    final favoriteObject = ParseObject(keyFavoritesTable);
    favoriteObject.set<String>(keyFavoritesOwner, user.id);
    favoriteObject.set<ParseObject>(
        keyFavoritesAd, ParseObject(keyAdTable)..set<String>(keyAdId, ad.id));
    final response = await favoriteObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> removeFromFavorite(Ad ad, User user) async {
    final QueryBuilder queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));
    queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);
    queryBuilder.whereEqualTo(
        keyFavoritesAd, ParseObject(keyAdTable)..set(keyAdId, ad.id));
    try {
      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        for (final ParseObject favorite in response.results) {
          favorite.delete();
        }
      }
    } catch (e) {
      return Future.error('Erro ao remover de favoritos');
    }
  }

  Future<Set<Ad>> getFavoritesList(User user) async {
    final QueryBuilder queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));
    queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);
    queryBuilder.includeObject([keyFavoritesAd, 'ad.images', 'ad.owner']);

    final response = await queryBuilder.query();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
    if (response.success && response.results != null) {
      return response.results.map<Ad>((favoriteAd) {
        final parseAd = favoriteAd.get(keyFavoritesAd);
        return Ad.fromParse(parseAd);
      }).toSet();
    }
    return Set<Ad>();
  }
}
