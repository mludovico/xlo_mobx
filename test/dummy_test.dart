import 'package:flutter_test/flutter_test.dart';
import 'package:xlo_mobx/models/Address.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';

void main() {
  final regExp = RegExp(r"^[0-9]{8}$");
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Pass null to regex hasmatch', () {
    try {
      regExp.hasMatch(null);
    } on Exception catch (e) {
      print(e.toString());
    }
    expect(regExp.hasMatch(null),
        throwsA(equals('Invalid argument(s) (input): Must not be null')));
  });

  test('Pass incorret to regex hasmatch', () {
    expect(regExp.hasMatch('2342'), equals(false));
  });

  test('Pass correct to regex hasmatch', () {
    expect(regExp.hasMatch('23434545'), equals(true));
  });

  test('Ceprepository invalidcep should return invalid', () {
    expect(CepRepository().getAddress('234'),
        equals(Future.error('CEP Inválido')));
  });

  test('Ceprepository valid should return address', () async {
    expect(await CepRepository().getAddress('13070091'), isA<Address>());
  });

  test('Ceprepository invalidcep should return invalid', () {
    expect(CepRepository().getAddress('234'),
        equals(Future.error('CEP Inválido')));
  });
}
