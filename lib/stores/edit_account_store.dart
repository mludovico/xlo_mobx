import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/session_store.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    sessionStore = GetIt.I<SessionStore>();
    userType = sessionStore.user.type;
    name = sessionStore.user.name;
    phone = sessionStore.user.phone;
  }
  SessionStore sessionStore;

  @observable
  UserType userType;

  @action
  void setUserType(int index) => userType = UserType.values[index];

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @observable
  String passwordConfirmation = '';

  @action
  void setPasswordConfirmation(String value) => passwordConfirmation = value;

  @observable
  bool loading = false;

  @action
  setLoading(bool value) => loading = value;

  @observable
  String generalError;

  @action
  void setGeneralError(String value) => generalError = value;

  @computed
  bool get nameIsValid => name != null && name.length > 3;
  bool get phoneIsValid => phone != null && phone.length >= 14;
  bool get passwordIsValid => password.length >= 6 || password.isEmpty;
  bool get passwordConfirmationIsValid => passwordConfirmation == password;
  bool get canSave =>
      nameIsValid &&
      phoneIsValid &&
      passwordIsValid &&
      passwordConfirmationIsValid &&
      !loading;
  String get nameError =>
      nameIsValid || name != null ? null : 'Campo obrigatório.';
  String get phoneError =>
      phoneIsValid || phone != null ? null : 'Campo obrigatório.';
  String get passwordError => passwordIsValid || password == null
      ? null
      : 'A senha deve ter pelo menos 6 carateres.';
  String get passwordConfirmationError {
    if (password.isNotEmpty && passwordConfirmation.isEmpty)
      return 'Campo obrigatório.';
    if (!passwordConfirmationIsValid)
      return 'A senha não coincide.';
    else
      return null;
  }

  Function get save => canSave
      ? () async {
          setLoading(true);
          var user = sessionStore.user;
          user.name = name;
          user.phone = phone;
          user.type = userType;
          user.password = password.isNotEmpty ? password : null;

          try {
            await UserRepository().save(user);
            sessionStore.setUser(user);
          } catch (e) {
            setGeneralError(e.toString());
          }

          setLoading(false);
        }
      : null;

  void logout() async {
    await sessionStore.logout();
  }
}
