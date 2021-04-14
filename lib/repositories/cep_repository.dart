import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/Address.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

class CepRepository {
  static const String BasePath = 'https://viacep.com.br/ws';

  Future<Address> getAddress(String cep) async {
    final regExp = RegExp(r"^[0-9]{8}$");
    if (cep == null || !regExp.hasMatch(cep))
      return Future.error('CEP inválido');

    final endpoint = '$BasePath/$cep/json';

    try {
      final response = await Dio().get<Map>(endpoint);
      if (response.data.containsKey('erro') && response.data['erro']) {
        return Future.error('CEP Inválivo');
      } else {
        final ufList = await IBGERepository().getStates();
        Address address = Address.fromJson(response.data)
          ..uf = ufList
              .firstWhere((element) => element.initials == response.data['uf'])
          ..city = City(name: response.data['localidade']);
        return address;
      }
    } catch (dioError) {
      return Future.error(dioError);
    }
  }
}
