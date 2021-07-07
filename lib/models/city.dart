import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class City {
  City({this.id, this.name});

  int id;
  String name;

  factory City.fromJson(Map json) => City(
        id: json['id'],
        name: json.keys.contains('nome') ? json['nome'] : json['city'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': name,
      };

  factory City.fromParse(ParseObject pObject) => City(
        id: pObject.get('id'),
        name: pObject.get('nome') ?? pObject.get('city'),
      );

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }
}
