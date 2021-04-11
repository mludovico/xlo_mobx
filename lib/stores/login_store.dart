import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/session_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email;

  @action
  void setEmail(String value) {
    email = value;
    error = null;
  }

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String pass;

  @action
  void setPass(String value) {
    pass = value;
    error = null;
  }

  @computed
  bool get passValid => pass != null && pass.length >= 4;
  String get passError =>
    pass == null || passValid ? null : 'Senha inválida';
  bool get isFormValid => emailValid && passValid;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  VoidCallback get signIn => isFormValid && !loading ? () async {
    setLoading(true);
    final user = User(mail: email, password: pass);
    try {
      final retrievedUser = await UserRepository().signIn(user);
      print(retrievedUser);
      GetIt.I<SessionStore>().setUser(retrievedUser);

    } catch (e) {
      setError(e.toString());
    }
    setLoading(false);
  } : null;

}