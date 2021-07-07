import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  String id;
  List images = [];
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone = false;
  AdStatus status;
  DateTime created;
  User user;
  int views;

  Ad({
    this.id,
    this.images,
    this.title,
    this.description,
    this.category,
    this.address,
    this.price,
    this.hidePhone = false,
    this.status = AdStatus.PENDING,
    this.created,
    this.user,
    this.views,
  });

  factory Ad.fromParse(ParseObject pObject) => Ad(
        id: pObject.get(keyAdId),
        images: pObject.get(keyAdImages).map((item) => item['url']).toList(),
        title: pObject.get(keyAdTitle),
        description: pObject.get(keyAdDescription),
        category: Category.fromParse(pObject.get(keyAdCategory)
          ..objectId = pObject[keyAdCategory][keyCategoryId]),
        address: Address.fromParse(pObject),
        price: pObject[keyAdPrice],
        hidePhone: pObject[keyAdHidePhone],
        status: AdStatus.values[pObject[keyAdStatus]],
        created: pObject[keyAdCreated],
        user: User.fromParse(
            pObject.get(keyAdOwner)..objectId = pObject[keyAdOwner][keyUserId]),
        views: pObject[keyAdViews],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'images': images,
        'title': title,
        'description': description,
        'category': category,
        'address': address,
        'price': price,
        'hidePhone': hidePhone,
        'status': status,
        'created': created,
        'user': user,
        'views': views,
      };
}
