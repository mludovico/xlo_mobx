class UF {
  int id;
  String initials;
  String name;

  UF({this.id, this.initials, this.name});

  factory UF.fromJson(Map json) => UF(
        id: json['id'],
        initials: json['sigla'],
        name: json['nome'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sigla': initials,
        'nome': name,
      };

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name}';
  }
}
