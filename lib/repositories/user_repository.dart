import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(
      user.mail,
      user.password,
      user.mail,
    );
    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set<int>(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    if (response.success) {
      print(response.result);
      return User.fromJson(parseUser.toJson());
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> signIn(User user) async {
    final parseUser = ParseUser(
      user.mail,
      user.password,
      null,
    );

    final response = await parseUser.login();

    if (response.success) {
      return User.fromJson(parseUser.toJson());
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    print(parseUser);
    print('type of parse user: ${parseUser.runtimeType}');
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success) {
        return User.fromJson(response.result.toJson());
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  Future<void> logout() async {
    final ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      await parseUser.logout();
    }
  }

  Future<void> save(User user) async {
    final ParseUser parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      parseUser.set<String>(keyUserName, user.name);
      parseUser.set<String>(keyUserPhone, user.phone);
      parseUser.set<int>(keyUserType, user.type.index);
      if (user.password != null) {
        parseUser.password = user.password;
      }

      final response = await parseUser.save();
      if (!response.success) {
        Future.error(ParseErrors.getDescription(response.error.code));
      }

      if (user.password != null) {
        await parseUser.logout();
        final loginResponse =
            await ParseUser(user.mail, user.password, user.mail).login();
        if (!loginResponse.success) {
          return Future.error(ParseErrors.getDescription(response.error.code));
        }
      }
    }
  }
}
