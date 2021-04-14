import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class IBGERepository {
  static const baseUrl = 'https://servicodados.ibge.gov.br/api/v1/localidades';

  Future<List<UF>> getStates() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('UF_LIST')) {
      final decodedList = jsonDecode(preferences.getString('UF_LIST'));
      final List<UF> ufList =
          decodedList.map<UF>((uf) => UF.fromJson(uf)).toList();
      ufList
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return ufList;
    }
    const String endpoint = '$baseUrl/estados';
    try {
      final response = await Dio().get(endpoint);
      if (response.statusCode == 200) {
        preferences.setString('UF_LIST', jsonEncode(response.data));
        final List<UF> ufList =
            response.data.map<UF>((jsonUf) => UF.fromJson(jsonUf)).toList();
        ufList.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return ufList;
      } else
        return <UF>[];
    } on DioError catch (dioError) {
      return Future.error(dioError.message);
    }
  }

  Future<List<City>> getCities(UF uf) async {
    final String endpoint = '$baseUrl/estados/${uf.id}/municipios';
    try {
      final response = await Dio().get(endpoint);
      if (response.statusCode == 200) {
        final List<City> cityList = response.data
            .map<City>((jsonCity) => City.fromJson(jsonCity))
            .toList();
        cityList.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return cityList;
      } else
        return <City>[];
    } on DioError catch (dioError) {
      return Future.error(dioError.message);
    }
  }
}
