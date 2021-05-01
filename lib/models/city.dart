class City {
  City({this.id, this.name});

  int id;
  String name;

  factory City.fromJson(Map json) => City(
        id: json['id'],
        name: json.keys.contains('nome') ? json['nome'] : json['city'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': name,
      };

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }
}
