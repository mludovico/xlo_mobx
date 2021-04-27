import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
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
    this.hidePhone,
    this.status = AdStatus.PENDING,
    this.created,
    this.user,
    this.views,
  });

  factory Ad.fromJson(Map json) => Ad(
        id: json[keyAdId],
        images: json[keyAdImages].map((item) => item['url']).toList(),
        title: json[keyAdTitle],
        description: json[keyAdDescription],
        category: Category.fromParse(
            ParseObject(json[keyAdCategory]['className'])
              ..objectId = json[keyAdCategory][keyCategoryId]),
        address: Address.fromJson(json),
        price: json[keyAdPrice],
        hidePhone: json[keyAdHidePhone],
        status: AdStatus.values[json[keyAdStatus]],
        created: DateTime.parse(json[keyAdCreated]),
        user: User.fromJson(json[keyAdOwner]),
        views: json[keyAdViews],
      );
}
