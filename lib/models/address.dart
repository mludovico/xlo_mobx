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
        district: json['bairro'],
      );

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, district: $district}';
  }
}
