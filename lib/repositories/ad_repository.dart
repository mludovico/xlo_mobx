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
        final ad = Ad.fromJson(result);
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
  }) async {
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));
    queryBuilder.includeObject([keyAdOwner, keyAdCategory]);
    queryBuilder.setLimit(20);
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
      case OrderBy.PRICE:
        queryBuilder.orderByDescending(keyAdCreated);
        break;
      case OrderBy.DATE:
      default:
        queryBuilder.orderByAscending(keyAdPrice);
        break;
    }
    if (filter.minPrice != null && filter.minPrice > 0) {
      queryBuilder.whereGreaterThan(keyAdPrice, filter.minPrice);
    }
    if (filter.maxPrice != null && filter.maxPrice > 0) {
      queryBuilder.whereGreaterThan(keyAdPrice, filter.maxPrice);
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
      return response.results
          .map((pObject) => Ad.fromJson(pObject.toJson()))
          .toList();
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
