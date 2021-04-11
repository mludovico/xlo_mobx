import 'package:xlo_mobx/repositories/table_keys.dart';

enum UserType { PARTICULAR, PROFESSIONAL }

class User {

  String id;
  String name;
  String mail;
  String phone;
  String password;
  UserType type;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.name,
    this.mail,
    this.phone,
    this.password,
    this.type = UserType.PARTICULAR
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json[keyUserId] ?? '',
    name: json[keyUserName] ?? '',
    mail: json[keyUserMail] ?? '',
    phone: json[keyUserPhone] ?? '',
    password: json['password'] ?? '',
    type: UserType.values[json[keyUserType]] ?? UserType.PARTICULAR,
    createdAt: DateTime.parse(json[keyUserCreated]),
    updatedAt: DateTime.parse(json[keyUserUpdated]),
  );

  Map<String, dynamic> toJson() => {
    keyUserId: id ?? '',
    keyUserName: name ?? '',
    keyUserMail: mail ?? '',
    keyUserPhone: phone ?? '',
    'password': password ?? '',
    keyUserType: type.index ?? UserType.PARTICULAR.index,
    keyUserCreated: createdAt,
    keyUserUpdated: updatedAt,
  };

  @override
  String toString() {
    return 'User{id: $id, name: $name, mail: $mail, phone: $phone,'
        ' password: $password, type: $type, createdAt: $createdAt,'
        ' updatedAt: $updatedAt}';
  }
}