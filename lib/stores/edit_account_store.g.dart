// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAccountStore on _EditAccountStore, Store {
  Computed<bool> _$nameIsValidComputed;

  @override
  bool get nameIsValid =>
      (_$nameIsValidComputed ??= Computed<bool>(() => super.nameIsValid,
              name: '_EditAccountStore.nameIsValid'))
          .value;

  final _$userTypeAtom = Atom(name: '_EditAccountStore.userType');

  @override
  UserType get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserType value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  final _$nameAtom = Atom(name: '_EditAccountStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$phoneAtom = Atom(name: '_EditAccountStore.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$passwordAtom = Atom(name: '_EditAccountStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$passwordConfirmationAtom =
      Atom(name: '_EditAccountStore.passwordConfirmation');

  @override
  String get passwordConfirmation {
    _$passwordConfirmationAtom.reportRead();
    return super.passwordConfirmation;
  }

  @override
  set passwordConfirmation(String value) {
    _$passwordConfirmationAtom.reportWrite(value, super.passwordConfirmation,
        () {
      super.passwordConfirmation = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditAccountStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$generalErrorAtom = Atom(name: '_EditAccountStore.generalError');

  @override
  String get generalError {
    _$generalErrorAtom.reportRead();
    return super.generalError;
  }

  @override
  set generalError(String value) {
    _$generalErrorAtom.reportWrite(value, super.generalError, () {
      super.generalError = value;
    });
  }

  final _$_EditAccountStoreActionController =
      ActionController(name: '_EditAccountStore');

  @override
  void setUserType(int index) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setUserType');
    try {
      return super.setUserType(index);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordConfirmation(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPasswordConfirmation');
    try {
      return super.setPasswordConfirmation(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeneralError(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setGeneralError');
    try {
      return super.setGeneralError(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userType: ${userType},
name: ${name},
phone: ${phone},
password: ${password},
passwordConfirmation: ${passwordConfirmation},
loading: ${loading},
generalError: ${generalError},
nameIsValid: ${nameIsValid}
    ''';
  }
}
