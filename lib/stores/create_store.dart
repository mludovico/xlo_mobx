import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/session_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (imagesValid || !showErrors)
      return null;
    else
      return 'Insira uma imagem';
  }

  @observable
  String title;

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title != null && title.length > 5;
  String get titleError {
    if (title == null || titleValid || !showErrors)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String description;

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description != null && description.length > 10;
  String get descriptionError {
    if (description == null || descriptionValid || !showErrors)
      return null;
    else if (description.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if (categoryValid || !showErrors)
      return null;
    else
      return 'Campo obrigatório';
  }

  CepStore cepStore = CepStore();

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError {
    if (addressValid || !showErrors)
      return null;
    else
      return 'Campo obrigatório';
  }

  @observable
  String priceText = '';

  @action
  void setPriceText(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp(r"[^0-9]"), '')) / 100;
    } else
      return num.tryParse(priceText);
  }

  bool get priceValid => price != null && price < 10000000;
  String get priceError {
    if (priceValid || !showErrors)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Campo inválido';
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  @computed
  bool get isFormValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  void setLoading(bool value) => loading = value;

  VoidCallback get sendAd => isFormValid && !loading
      ? () async {
          setLoading(true);
          print('started sending');
          await _send();
          setLoading(false);
          print('finished sending');
        }
      : null;

  @observable
  Ad savedAd;

  @action
  Future<void> _send() async {
    final ad = Ad(
      title: title,
      description: description,
      category: category,
      price: price,
      hidePhone: hidePhone,
      images: images,
      address: address,
      user: GetIt.I<SessionStore>().user,
    );
    try {
      savedAd = await AdRepository().save(ad);
      print(savedAd);
    } catch (e) {
      print('Deu ruim');
      error = e;
    }
  }
}
