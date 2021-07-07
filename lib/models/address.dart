import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class Address {
  Address({this.uf, this.city, this.cep, this.district});

  UF uf;
  City city;
  String cep;
  String district;

  factory Address.fromJson(Map json) => Address(
        cep: json['postalCode'] ?? json['cep'],
        city: City.fromJson(json),
        uf: UF(initials: json['uf']),
        district:
            json.keys.contains('bairro') ? json['bairro'] : json['district'],
      );

  factory Address.fromParse(ParseObject pObject) => Address(
        cep: pObject.get('postalCode') ?? pObject.get('cep'),
        city: City.fromParse(pObject),
        uf: UF(initials: pObject.get('uf')),
        district: pObject.get('bairro') ?? pObject.get('district'),
      );

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, district: $district}';
  }
}
