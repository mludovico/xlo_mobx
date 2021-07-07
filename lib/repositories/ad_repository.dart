import 'dart:convert';
import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class AdRepository {
  Future<Ad> save(Ad ad) async {
    final parseImages = await saveImages(ad.images);
    final parseUser = ParseUser('', '', '')..set(keyUserId, ad.user.id);
    final adObject = ParseObject(keyAdTable);
    final parseAcl = ParseACL(owner: parseUser);

    parseAcl.setPublicReadAccess(allowed: true);
    parseAcl.setPublicWriteAccess(allowed: false);
    adObject.setACL(parseAcl);

    adObject.objectId = ad.id;
    adObject.set<String>(keyAdTitle, ad.title);
    adObject.set<String>(keyAdDescription, ad.description);
    adObject.set<bool>(keyAdHidePhone, ad.hidePhone);
    adObject.set<num>(keyAdPrice, ad.price);
    adObject.set<int>(keyAdStatus, ad.status.index);
    adObject.set<String>(keyAdDistrict, ad.address.district);
    adObject.set<String>(keyAdCity, ad.address.city.name);
    adObject.set<String>(keyAdUF, ad.address.uf.initials);
    adObject.set<String>(keyAdPostalCode, ad.address.cep);
    adObject.set<List<ParseFile>>(keyAdImages, parseImages);
    adObject.set<ParseUser>(keyAdOwner, parseUser);
    adObject.set<ParseObject>(keyAdCategory,
        ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));
    try {
      final response = await adObject.save();
      if (response.success) {
        final result = jsonDecode(response.result.toString());
        print('Resultado: $result');
        final ad = Ad.fromParse(response.result);
        print(ad.title);
        return ad;
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      print(e);
      return Future.error('Erro ao salvar anúncio');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(
            image,
            name: path.basename(image.path),
          );
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error.code));
          }
          parseImages.add(parseFile);
        } else if (image is String) {
          final parseFile = ParseFile(
            null,
            name: path.basename(image),
            url: image,
          );
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Ad>> getHomeAdList({
    FilterStore filter,
    String search,
    Category category,
    int page,
  }) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));
    queryBuilder.includeObject([keyAdOwner, keyAdCategory]);
    queryBuilder.setAmountToSkip(page * 10);
    queryBuilder.setLimit(10);
    queryBuilder.whereEqualTo(keyAdStatus, AdStatus.ACTIVE.index);
    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);
    }
    if (category != null && category.id != '*') {
      final foundCategory = ParseObject(keyCategoryTable)
        ..set(keyCategoryId, category.id);
      queryBuilder.whereEqualTo(
        keyAdCategory,
        foundCategory.toPointer(),
      );
    }
    switch (filter.orderBy) {
      case OrderBy.DATE:
        queryBuilder.orderByDescending(keyAdCreated);
        break;
      case OrderBy.PRICE:
      default:
        queryBuilder.orderByAscending(keyAdPrice);
        break;
    }
    if (filter.minPrice != null && filter.minPrice > 0) {
      queryBuilder.whereGreaterThan(keyAdPrice, filter.minPrice);
    }
    if (filter.maxPrice != null && filter.maxPrice > 0) {
      queryBuilder.whereLessThan(keyAdPrice, filter.maxPrice);
    }
    if (filter.vendorType != null &&
        filter.vendorType > 0 &&
        filter.vendorType <=
            VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL) {
      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());
      if (filter.vendorType == VENDOR_TYPE_PARTICULAR) {
        userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
      }
      if (filter.vendorType == VENDOR_TYPE_PROFESSIONAL) {
        userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
      }
      queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);
    }
    final response = await queryBuilder.query();
    if (response.success && response.results == null) {
      return <Ad>[];
    } else if (response.success) {
      return response.results.map((pObject) => Ad.fromParse(pObject)).toList();
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<List<Ad>> getMyAds(User user) async {
    final currentUser = ParseUser('', '', '')..set(keyUserId, user.id);
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));
    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyAdCreated);
    queryBuilder.whereEqualTo(keyAdOwner, currentUser.toPointer());
    queryBuilder.includeObject([keyAdCategory, keyAdOwner]);
    final response = await queryBuilder.query();
    if (response.success && response.results == null) {
      return <Ad>[];
    } else if (response.success) {
      return response.results
          .map<Ad>((pObject) => Ad.fromParse(pObject))
          .toList();
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> sell(Ad ad) async {
    final parseObject = ParseObject(keyAdTable)
      ..set(keyAdId, ad.id)
      ..set(keyAdStatus, AdStatus.SOLD.index);
    final response = await parseObject.save();
    if (!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<void> delete(Ad ad) async {
    final parseObject = ParseObject(keyAdTable)
      ..set(keyAdId, ad.id)
      ..set(keyAdStatus, AdStatus.DELETED.index);
    final response = await parseObject.save();
    if (!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));
  }
}
