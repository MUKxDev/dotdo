import 'dart:convert';

class Group {
  final String name;
  final String picture;
  final int noOfmemeber;
  Group({
    this.name,
    this.picture,
    this.noOfmemeber,
  });

  Group copyWith({
    String name,
    String picture,
    int noOfmemeber,
  }) {
    return Group(
      name: name ?? this.name,
      picture: picture ?? this.picture,
      noOfmemeber: noOfmemeber ?? this.noOfmemeber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'picture': picture,
      'noOfmemeber': noOfmemeber,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Group(
      name: map['name'],
      picture: map['picture'],
      noOfmemeber: map['noOfmemeber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() =>
      'Group(name: $name, picture: $picture, noOfmemeber: $noOfmemeber)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Group &&
        o.name == name &&
        o.picture == picture &&
        o.noOfmemeber == noOfmemeber;
  }

  @override
  int get hashCode => name.hashCode ^ picture.hashCode ^ noOfmemeber.hashCode;
}
